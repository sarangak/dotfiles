------------------------------------------------------------
-- Window-management modules
------------------------------------------------------------

------------------------------------------------------------
-- Switcher
------------------------------------------------------------
--[[
  Command-Tab and Command-Shift-Tab switch forward and
  backward over all visible windows.

  Option-Tab and Option-Shift-Tab switch forward and
  backward over the windows of the currently focused
  application.
--]]

-- Settings
hs.window.animationDuration = 0
hs.window.switcher.ui.showSelectedTitle = false
hs.window.switcher.ui.showSelectedThumbnail = true
hs.window.switcher.ui.showThumbnails = false

-- Override default behavior of avoiding 1Password miniwindows
hs.window.filter.default:allowApp'1Password mini'
hs.window.filter.default:allowApp'1Password Extension Helper'

local switcher = hs.window.switcher.new()
local function nextWindow()
  switcher:next()
end
local function prevWindow()
  switcher:previous()
end
hs.hotkey.bind('alt', 'tab', nextWindow)
hs.hotkey.bind({'alt', 'shift'}, 'tab', prevWindow)

local mySwitchers = {}
local function currentAppSwitcher()
  local currentAppName = hs.window.focusedWindow():application():name()
  if mySwitchers[currentAppName] == nil then
    mySwitchers[currentAppName] = hs.window.switcher.new(currentAppName)
  end
  return mySwitchers[currentAppName]
end
local function nextAppWindow()
  currentAppSwitcher():next()
end
local function prevAppWindow()
  currentAppSwitcher():previous()
end
-- NOTE: I'm using Karabiner to remap cmd-tab to ctrl-F4 because Hammerspoon can't currently capture cmd-tab away from macOS
hs.hotkey.bind({'ctrl'}, 'F4', nextAppWindow)
hs.hotkey.bind({'ctrl', 'shift'}, 'F4', prevAppWindow)



------------------------------------------------------------
-- Hints
------------------------------------------------------------
--[[
  Select window to focus by pressing a hotkey and selecting
  the letter for the window you want
--]]

expose = hs.expose.new(nil,{includeNonVisible=false})
expose_app = hs.expose.new(nil,{onlyActiveApplication=true})
local function showExpose()
  expose:toggleShow()
end
local function showAppExpose()
  expose_app:toggleShow()
end
hs.hotkey.bind({"ctrl"}, ';', showExpose)
hs.hotkey.bind({"ctrl", "alt"}, ';', showAppExpose)


------------------------------------------------------------
-- Quickswitch
------------------------------------------------------------
--[[
  Use hotkeys to switch between applications

  If the application isn't running, the hotkey will start
  it.
--]]

hs.fnutils.each({
    { key = "b", app = 'Google Chrome' },
    { key = "h", app = 'Slack' },
    { key = "m", app = "iTerm" },
    { key = "space", app = "Emacs" },
  },
  function(object)
    local appKey = object.key
    local appName = object.app
    local function switchApp()
      local hsapp = hs.application.find(appName)

      if hsapp and hsapp:mainWindow() then
        hsapp:mainWindow():focus()
        -- Alternative way of doing the same thing?
        -- hsapp:setFrontmost()
      else
        -- launchOrFocus will bring all windows of the application forward, which is not what I want
        hs.application.launchOrFocus(appName)
      end
    end

    hs.hotkey.bind('ctrl-alt', appKey, switchApp)
end)

-- Vimium tab selector
--[[
  Make ctrl-alt-o switch to the Vimium tab selector

  Assumes that your Chrome windows have the "New Tab" page
  open as the first tab and the focus is not in the omnibar.

  ctrl-alt-t was my first choice for a keybinding but it
  is swallowed by Chrome (doesn't make it to Hammerspoon if
  Chrome is focused)
--]]

local function vimiumTabSwitch()
  hs.application.launchOrFocus('Google Chrome')
  hs.eventtap.keyStroke({'cmd'}, "1")
  hs.eventtap.keyStroke({'shift'}, 't')
end
hs.hotkey.bind('ctrl-alt', "o", nil, vimiumTabSwitch)

------------------------------------------------------------
-- Screen capture current window
------------------------------------------------------------
--[[
  Make cmd + alt + shift + s save a screenshot of the current window.  Global vars like `screenshotPrefix` are used to customize the filename and location of screenshots. Used to make it more efficient to capture screenshots.
--]]
screenshotDir = "Desktop"
screenshotPrefix = "ss-"
local function screenCapture()
  local timeStamp = string.gsub(os.date("%Y%m%d_%T"), ":", "")
  local fileName = os.getenv("HOME") .. "/" .. screenshotDir .. "/" .. screenshotPrefix .. timeStamp .. ".png"
  local windowId = hs.window.frontmostWindow():id()
  hs.alert.show("Capturing to " .. fileName)
  local saveToClip = function(exitCode, stdOut, std)
      local image = hs.image.imageFromPath(fileName)
      hs.pasteboard.writeObjects(image)
  end
  hs.task.new("/usr/sbin/screencapture", saveToClip, {"-l" .. windowId, fileName }):start()
end
hs.hotkey.bind('cmd-alt-shift', "s", nil, screenCapture)

------------------------------------------------------------
-- Mute microphone in Meet/Zoom
------------------------------------------------------------
--[[
  Make ctrl + shift + m switch to Meet/Zoom and mute the microphone
--]]

local function toggleMute()
  local oldWindow = hs.window.focusedWindow()

  local meetWindow = hs.window.find('^Meet')
  if meetWindow then
    meetWindow:focus()
    -- Meet's keyboard shortcut for muting the microphone is cmd-d
    hs.eventtap.keyStroke({'cmd'}, "d")
    oldWindow:focus()
    return
  end

  local zoomWindow = hs.window.find('^Zoom Meeting')
  if zoomWindow then
    zoomWindow:focus()
    -- Zoom's keyboard shortcut for muting the microphone is shift-cmd-a
    hs.eventtap.keyStroke({'shift', 'cmd'}, "a")
    oldWindow:focus()
    return
  end
end
hs.hotkey.bind({'ctrl', 'shift'}, 'm', nil, toggleMute)


------------------------------------------------------------
-- Resize/position current window
------------------------------------------------------------
--[[
  Emulate Slate resize/positioning macros
--]]

local slateKeys = {'ctrl', 'alt', 'cmd'}

local sizes = {0.5, 0.333333, 0.666667}
local fullScreenSizes = {1, 0.75, 0.5}

local GRID = {w = 24, h = 24}
hs.grid.setGrid(GRID.w .. 'x' .. GRID.h)
hs.grid.MARGINX = 0
hs.grid.MARGINY = 0

local function round(x)
  return math.floor(x + 0.5) -- doesn't work with negative numbers but I don't need them
end

local function nextStep(sizeDim, posDim, padPos)
  if not hs.window.focusedWindow() then
    return
  end

  local win = hs.window.frontmostWindow()
  local cell = hs.grid.get(win)

  local nextSize = sizes[1]
  for i=1,#sizes do
    local sizeFactor = sizes[i]
    if cell[sizeDim] == round(GRID[sizeDim] * sizeFactor) and
      ((padPos and cell[posDim] == round(GRID[sizeDim] - GRID[sizeDim] * sizeFactor)) or
        (not padPos and cell[posDim] == 0))
    then
      nextSize = sizes[(i % #sizes) + 1]
      break
    end
  end

  cell[sizeDim] = round(GRID[sizeDim] * nextSize)
  if padPos then
    cell[posDim] = GRID[sizeDim] - cell[sizeDim]
  else
    cell[posDim] = 0
  end
  hs.grid.set(win, cell)
end
local function nextStepUp()
  nextStep('h', 'y', false)
end
local function nextStepDown()
  nextStep('h', 'y', true)
end
local function nextStepLeft()
  nextStep('w', 'x', false)
end
local function nextStepRight()
  nextStep('w', 'x', true)
end

local function nextFullScreenStep()
  if not hs.window.focusedWindow() then
    return
  end

  local win = hs.window.frontmostWindow()
  local cell = hs.grid.get(win)

  local nextSize = fullScreenSizes[1] -- default to fullscreen if the window doesn't match the grid
  for i=1,#fullScreenSizes do
    local sizeFactor = fullScreenSizes[i]
    if cell.w == round(GRID.w * sizeFactor) and
      cell.h == round(GRID.h * sizeFactor) and
      cell.x == round((GRID.w - GRID.w * sizeFactor) / 2) then
      nextSize = fullScreenSizes[(i % #fullScreenSizes) + 1]
      break
    end
  end

  cell.w = round(GRID.w * nextSize)
  cell.h = round(GRID.h * nextSize)
  cell.x = round((GRID.w - GRID.w * nextSize) / 2)
  cell.y = 0
  hs.grid.set(win, cell)
end

hs.hotkey.bind(slateKeys, "k", nextStepUp)
hs.hotkey.bind(slateKeys, "j", nextStepDown)
hs.hotkey.bind(slateKeys, "h", nextStepLeft)
hs.hotkey.bind(slateKeys, "l", nextStepRight)
hs.hotkey.bind(slateKeys, "i", nextFullScreenStep)

-- For debugging
-- hs.hotkey.bind(slateKeys, "i", function ()
--   local win = hs.window.frontmostWindow()
--   local id = win:id()
--   local screen = win:screen()
--   cell = hs.grid.get(win, screen)
--   hs.alert.show(cell)
-- end)


------------------------------------------------------------
-- Move window to another screen
------------------------------------------------------------
--[[
  Hotkeys assume two screens: 0 and 1
--]]

local function moveWindowEast()
  local win = hs.window.frontmostWindow()
  win:moveOneScreenEast(false, true)
end
local function moveWindowWest()
  local win = hs.window.frontmostWindow()
  win:moveOneScreenWest(false, true)
end
hs.hotkey.bind(slateKeys, "2", moveWindowEast)
hs.hotkey.bind(slateKeys, "1", moveWindowWest)

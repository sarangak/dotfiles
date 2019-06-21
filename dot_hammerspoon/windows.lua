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


local switcher = hs.window.switcher.new()
-- NOTE: I'm using Karabiner to remap cmd-tab to ctrl-F4 because Hammerspoon can't currently capture cmd-tab away from macOS
hs.hotkey.bind({'ctrl'}, 'F4', function()
                 switcher:next()
end)
hs.hotkey.bind({'ctrl', 'shift'}, 'F4', function()
                 switcher:previous()
end)

local mySwitchers = {}
function currentApplicationSwitcher()
  local currentApplication = hs.window.focusedWindow():application():name()
  if mySwitchers[currentApplication] == nil then
    mySwitchers[currentApplication] = hs.window.switcher.new(currentApplication)
  end
  return mySwitchers[currentApplication]
end
hs.hotkey.bind('alt', 'tab', function()
                 currentApplicationSwitcher():next()
end)
hs.hotkey.bind({'alt', 'shift'}, 'tab', function()
                 currentApplicationSwitcher():previous()
end)


------------------------------------------------------------
-- Hints
------------------------------------------------------------
--[[
  Select window to focus by pressing a hotkey and selecting
  the letter for the window you want
--]]

-- Use Vimium hint order (prefer home row)
-- hs.hints.hintChars = {'S', 'A', 'D', 'F', 'J', 'K', 'L', 'E', 'W', 'C', 'M', 'P', 'G', 'H'}
hs.hints.showTitleThresh = 0


hs.hotkey.bind({"ctrl"}, ';', function()
    hs.hints.style = 'vimperator'
    hs.hints.windowHints()
    hs.hints.style = 'default'
end)

-- Hint within current application
hs.hotkey.bind({"ctrl", "alt"}, ';', function()
    hs.hints.windowHints(hs.window.focusedWindow():application():allWindows())
end)


------------------------------------------------------------
-- Quickswitcher
------------------------------------------------------------
--[[
  Use hotkeys to switch between applications

  If the application isn't running, the hotkey will start
  it.
--]]

local focusKeys = {'ctrl', 'alt'}
hs.fnutils.each({
    { key = "b", app = 'Google Chrome' },
    { key = "h", app = 'Slack' },
    { key = "m", app = "iTerm" },
    { key = "space", app = "Emacs" },
  },
  function(object)
    hs.hotkey.bind(focusKeys, object.key, function()
      hs.application.launchOrFocus(object.app)
    end)
end)


------------------------------------------------------------
-- Mute microphone in Meet
------------------------------------------------------------
--[[
  Make ctrl + shift + m switch to Meet and mute the microphone
--]]

hs.hotkey.bind({'ctrl', 'shift'}, 'm', nil, function()
    local oldWindow = hs.window.focusedWindow()
    local meetWindow = hs.window.find('^Meet')

    meetWindow:focus()
    -- Meet's keyboard shortcut for muting the microphone is cmd-d
    hs.eventtap.keyStroke({'cmd'}, "d")
    oldWindow:focus()
end)


------------------------------------------------------------
-- Vimium tab selector
------------------------------------------------------------
--[[
  Make focusKeys + o switch to the Vimium tab selector

  Assumes that your Chrome windows have the "New Tab" page
  open as the first tab and the focus is not in the omnibar.

  focusKeys + t was my first choice for a keybinding but it
  is swallowed by Chrome (doesn't make it to Hammerspoon if
  Chrome is focused)
--]]

hs.hotkey.bind(focusKeys, "o", nil, function()
                 hs.application.launchOrFocus('Google Chrome')
                 hs.eventtap.keyStroke({'cmd'}, "1")
                 hs.eventtap.keyStroke({'shift'}, 't')
end)


------------------------------------------------------------
-- Resize/position current window
------------------------------------------------------------
--[[
  Emulate Slate resize/positioning macros

  Based on https://github.com/pstadler/dotfiles/blob/master/hammerspoon/position.lua

  Minor modifications:
  - Changed full screen sizes to be a little larger
  - Vim keys instead of arrow keys
--]]

local slateKeys = {'ctrl', 'alt', 'cmd'}

local sizes = {2, 3, 3/2}
local fullScreenSizes = {1, 4/3, 2}

local GRID = {w = 24, h = 24}
hs.grid.setGrid(GRID.w .. 'x' .. GRID.h)
hs.grid.MARGINX = 0
hs.grid.MARGINY = 0

local pressed = {
  up = false,
  down = false,
  left = false,
  right = false
}

function nextStep(dim, offs, cb)
  if hs.window.focusedWindow() then
    local axis = dim == 'w' and 'x' or 'y'
    local oppDim = dim == 'w' and 'h' or 'w'
    local oppAxis = dim == 'w' and 'y' or 'x'
    local win = hs.window.frontmostWindow()
    local id = win:id()
    local screen = win:screen()

    cell = hs.grid.get(win, screen)

    local nextSize = sizes[1]
    for i=1,#sizes do
      if cell[dim] == GRID[dim] / sizes[i] and
        (cell[axis] + (offs and cell[dim] or 0)) == (offs and GRID[dim] or 0)
        then
          nextSize = sizes[(i % #sizes) + 1]
        break
      end
    end

    cb(cell, nextSize)
    if cell[oppAxis] ~= 0 and cell[oppAxis] + cell[oppDim] ~= GRID[oppDim] then
      cell[oppDim] = GRID[oppDim]
      cell[oppAxis] = 0
    end

    hs.grid.set(win, cell, screen)
  end
end

function nextFullScreenStep()
  if hs.window.focusedWindow() then
    local win = hs.window.frontmostWindow()
    local id = win:id()
    local screen = win:screen()

    cell = hs.grid.get(win, screen)

    local nextSize = fullScreenSizes[1]
    for i=1,#fullScreenSizes do
      if cell.w == GRID.w / fullScreenSizes[i] and
        cell.h == GRID.h / fullScreenSizes[i] and
        cell.x == (GRID.w - GRID.w / fullScreenSizes[i]) / 2 then
        nextSize = fullScreenSizes[(i % #fullScreenSizes) + 1]
        break
      end
    end

    cell.w = GRID.w / nextSize
    cell.h = GRID.h / nextSize
    cell.x = (GRID.w - GRID.w / nextSize) / 2
    cell.y = 0

    hs.grid.set(win, cell, screen)
  end
end

function fullDimension(dim)
  if hs.window.focusedWindow() then
    local win = hs.window.frontmostWindow()
    local id = win:id()
    local screen = win:screen()
    cell = hs.grid.get(win, screen)

    if (dim == 'x') then
      cell = '0,0 ' .. GRID.w .. 'x' .. GRID.h
    else
      cell[dim] = GRID[dim]
      cell[dim == 'w' and 'x' or 'y'] = 0
    end

    hs.grid.set(win, cell, screen)
  end
end

hs.hotkey.bind(slateKeys, "j", function ()
  pressed.down = true
  if pressed.up then
    fullDimension('h')
  else
    nextStep('h', true, function (cell, nextSize)
      cell.y = GRID.h - GRID.h / nextSize
      cell.h = GRID.h / nextSize
    end)
  end
end, function ()
  pressed.down = false
end)

hs.hotkey.bind(slateKeys, "l", function ()
  pressed.right = true
  if pressed.left then
    fullDimension('w')
  else
    nextStep('w', true, function (cell, nextSize)
      cell.x = GRID.w - GRID.w / nextSize
      cell.w = GRID.w / nextSize
    end)
  end
end, function ()
  pressed.right = false
end)

hs.hotkey.bind(slateKeys, "h", function ()
  pressed.left = true
  if pressed.right then
    fullDimension('w')
  else
    nextStep('w', false, function (cell, nextSize)
      cell.x = 0
      cell.w = GRID.w / nextSize
    end)
  end
end, function ()
  pressed.left = false
end)

hs.hotkey.bind(slateKeys, "k", function ()
  pressed.up = true
  if pressed.down then
      fullDimension('h')
  else
    nextStep('h', false, function (cell, nextSize)
      cell.y = 0
      cell.h = GRID.h / nextSize
    end)
  end
end, function ()
  pressed.up = false
end)

hs.hotkey.bind(slateKeys, "i", function ()
  nextFullScreenStep()
end)

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

  Under the hood, uses moveOneScreenEast and moveOneScreenWest
--]]

hs.hotkey.bind(slateKeys, "2", function ()
  local win = hs.window.frontmostWindow()
  win:moveOneScreenEast(false, true)
end)

hs.hotkey.bind(slateKeys, "1", function ()
  local win = hs.window.frontmostWindow()
  win:moveOneScreenWest(false, true)
end)

-----------------------------------------------
-- Config
-----------------------------------------------

-- Hints
hs.hints.hintChars = {'S', 'A', 'D', 'F', 'J', 'K', 'L', 'E', 'W', 'C', 'M', 'P', 'G', 'H'}
hs.hints.showTitleThresh = 0
-- hs.hints.titleMaxSize = 20

-- Switcher
hs.window.animationDuration = 0
hs.window.switcher.ui.showSelectedTitle = false
hs.window.switcher.ui.showSelectedThumbnail = true
hs.window.switcher.ui.showThumbnails = false

-----------------------------------------------
-- Switcher
-----------------------------------------------

--[[
  Command-Tab and Command-Shift-Tab switch forward and backward over all visible
  windows.

  Option-Tab and Option-Shift-Tab switch forward and backward over the windows
  of the currently focused application.

--]]

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
hs.hotkey.bind('alt-shift', 'tab', function()
                 currentApplicationSwitcher():previous()
end)


-----------------------------------------------
-- Hints
-----------------------------------------------
hs.hotkey.bind({"ctrl"}, ';', function()
    hs.hints.windowHints()
end)

-- Hint within current application
hs.hotkey.bind({"ctrl", "alt"}, ';', function()
    hs.hints.showTitleThresh = 8
    hs.hints.windowHints(hs.window.focusedWindow():application():allWindows())
    hs.hints.showTitleThresh = 0
end)

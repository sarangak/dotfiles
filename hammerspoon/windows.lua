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


-----------------------------------------------
-- Quickswitch by app
-----------------------------------------------
local focusKeys = {'ctrl', 'alt'}
hs.fnutils.each({
    { key = "b", app = 'Google Chrome' },
    { key = "h", app = 'HipChat' },
    { key = "m", app = "iTerm" },
    { key = "space", app = "Emacs" },
  },
  function(object)
    hs.hotkey.bind(focusKeys, object.key, function()
      hs.application.launchOrFocus(object.app)
    end)
end)

-- Make focusKeys + o switch to the Vimium tab selector
-- NOTES:
-- - Assumes that your Chrome windows have the "New Tab" page open as the first
--   tab and the focus is not in the omnibar
-- - ctrl+alt+t was my first choice for a keybinding but it is swallowed by
--   Chrome (doesn't make it to Hammerspoon if Chrome is focused)
hs.hotkey.bind(focusKeys, "o", nil, function()
                 hs.application.launchOrFocus('Google Chrome')
                 hs.eventtap.keyStroke({'cmd'}, "1")
                 hs.eventtap.keyStroke({'shift'}, 't')
end)

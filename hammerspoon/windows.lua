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
local switcher = hs.window.switcher.new() -- default windowfilter: only visible windows, all Spaces

-- bind to hotkeys; WARNING: at least one modifier key is required!
-- NOTE: Using more than modifier key makes things buggy
-- Using Karabiner to remap cmd-tab to ctrl-F4 because Hammerspoon can't currently capture cmd-tab away from macOS
hs.hotkey.bind({'ctrl'}, 'F4', function()
                 switcher:next()
end)
hs.hotkey.bind({'ctrl', 'shift'}, 'F4', function()
                 switcher:previous()
end)

hs.hotkey.bind({'alt'}, 'tab', function()
    local current_app = hs.window.focusedWindow():application():name()
    hs.window.switcher.new({ current_app }):next()
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

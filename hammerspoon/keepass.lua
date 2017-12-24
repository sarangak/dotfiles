--[[
  First select the username field in the window you want to auto-type into, then
  select KeePass and press Cmd-Shift-v.
]]
emulateAutoType = hs.hotkey.new({'cmd', 'shift'}, 'v', function()
  -- Send copy username command
  hs.eventtap.keyStroke({'cmd'}, 'b')
  local username = hs.pasteboard.getContents()
  hs.pasteboard.clearContents()
  -- Send copy password command
  hs.eventtap.keyStroke({'cmd'}, 'c')
  local password = hs.pasteboard.getContents()
  hs.pasteboard.clearContents()

  -- Bring up the previous window and send keystrokes
  hs.window.orderedWindows()[2]:focus()
  hs.eventtap.keyStrokes(username)
  hs.eventtap.keyStroke({}, 'tab')
  hs.eventtap.keyStrokes(password)
  hs.eventtap.keyStroke({}, 'return')

end)

hs.window.filter.new('KeePassX')
:subscribe(hs.window.filter.windowFocused,function() emulateAutoType:enable() end)
:subscribe(hs.window.filter.windowUnfocused,function() emulateAutoType:disable() end)

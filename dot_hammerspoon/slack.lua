--[[
  Simple keystroke customizer for Slack
]]
local slackHotkeys = {
  hs.hotkey.new({'ctrl'}, '/', nil, function()
      hs.eventtap.keyStroke({'cmd'}, 'k')
  end),
  hs.hotkey.new({'ctrl', 'shift'}, '/', nil, function()
      hs.eventtap.keyStroke({'cmd', 'shift'}, 'k')
  end),
  hs.hotkey.new({'ctrl'}, 'h', nil, function()
      hs.eventtap.keyStroke({'cmd'}, '[')
  end),
  hs.hotkey.new({'ctrl'}, 'l', nil, function()
      hs.eventtap.keyStroke({'cmd'}, ']')
  end),
  hs.hotkey.new({'ctrl'}, 'k', nil, function()
      hs.eventtap.keyStroke({'alt', 'shift'}, 'up')
  end),
  hs.hotkey.new({'ctrl'}, 'u', nil, function()
      hs.eventtap.keyStroke({'cmd'}, 'up')
  end),
  hs.hotkey.new({'ctrl'}, 'j', nil, function()
      hs.eventtap.keyStroke({'alt', 'shift'}, 'down')
  end)
}

hs.window.filter.new('Slack')
  :subscribe(hs.window.filter.windowFocused,function()
               for _, k in pairs(slackHotkeys) do
                 k:enable()
               end
            end)
  :subscribe(hs.window.filter.windowUnfocused,function()
               for _, k in pairs(slackHotkeys) do
                 k:disable()
               end
            end)

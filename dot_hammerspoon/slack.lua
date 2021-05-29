--[[
  Simple keystroke customizer for Slack
]]
local slackHotkeys = {
  hs.hotkey.new({'ctrl'}, '/', nil, function()
      -- Search
      hs.eventtap.keyStroke({'cmd'}, 't')
  end),
  hs.hotkey.new({'ctrl', 'shift'}, '/', nil, function()
      -- Start a DM with multiple people
      hs.eventtap.keyStroke({'cmd', 'shift'}, 'k')
  end),
  hs.hotkey.new({'ctrl'}, 'h', nil, function()
      -- Go back in channel history
      hs.eventtap.keyStroke({'cmd'}, '[')
  end),
  hs.hotkey.new({'ctrl'}, 'l', nil, function()
      -- Go forward in channel history
      hs.eventtap.keyStroke({'cmd'}, ']')
  end),
  hs.hotkey.new({'ctrl'}, 'k', nil, function()
      -- Go up in channel list
      hs.eventtap.keyStroke({'alt', 'shift'}, 'up')
  end),
  hs.hotkey.new({'ctrl'}, 'j', nil, function()
      -- Go down in channel list
      hs.eventtap.keyStroke({'alt', 'shift'}, 'down')
  end),
  hs.hotkey.new({'ctrl'}, 'u', nil, function()
      -- Undo
      hs.eventtap.keyStroke({'cmd'}, 'up')
  end),
  hs.hotkey.new({'cmd'}, 'k', nil, function()
      -- Insert a link
      hs.eventtap.keyStroke({'cmd', 'shift'}, 'u')
  end)
}

-- Use non-anonymous function to improve performance
local function enableSlackKeys()
  -- Use this instead of pairs syntax to improve performance
  for k = 1, #slackHotkeys do
    slackHotkeys[k]:enable()
  end
end

local function disableSlackKeys()
  for k = 1, #slackHotkeys do
    slackHotkeys[k]:disable()
  end
end

hs.window.filter.new('Slack')
  :subscribe(hs.window.filter.windowFocused, enableSlackKeys)
  :subscribe(hs.window.filter.windowUnfocused, disableSlackKeys)

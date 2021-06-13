-----------------------------------------------
-- Set up
-----------------------------------------------

require "hs.ipc"
require "windows"
require "slack"

-----------------------------------------------
-- Reload with key binding
-----------------------------------------------

-- I can't seem to find a better solution than to periodically reload my config ;(
hs.hotkey.bind('ctrl-alt', "'", hs.reload)

-----------------------------------------------
-- Reload config on write
-----------------------------------------------

-- Store pathwatchers in a global so that they don't get garbage collected
myWatchers = {}
hs.fnutils.each({
    os.getenv("HOME") .. "/.hammerspoon/",
    os.getenv("HOME") .. "/.dotfiles/hammerspoon/",
                },
  function(path)
    if hs.fs.displayName(path) then
      -- Save the pathwatchers to a variable to avoid GC
      myWatchers[path] = hs.pathwatcher.new(path, hs.reload):start()
    end
  end
)
-- When the config is reloaded, we'll see this message.
hs.alert.show("Config loaded")

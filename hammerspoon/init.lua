-----------------------------------------------
-- Set up
-----------------------------------------------

require "windows"
require "keepass"

-----------------------------------------------
-- Reload config on write
-----------------------------------------------

function reloadConfig(files)
  doReload = false
  for _,file in pairs(files) do
    if file:sub(-4) == ".lua" then
      doReload = true
      break
    end
  end

  if doReload then
    hs.reload()
  end
end

hs.pathwatcher.new(os.getenv("HOME") ..
                     "/.hammerspoon/", reloadConfig):start()
hs.pathwatcher.new(os.getenv("HOME") ..
                     "/.dotfiles/hammerspoon/", reloadConfig):start()
hs.alert.show("Config loaded")

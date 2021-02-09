local awful = require("awful")
local apps = require("configuration.apps")

local function run_once(command)

  local findme = command
  local first_space = command:find(' ')

  if first_space then
    findme = command:sub(0, first_space - 1)
  end

  awful.spawn.with_shell(string.format("pgrep -u $USER -x %s > /dev/null || (%s)", findme, command))
end

for _, app in ipairs(apps.autostart) do
  run_once(app)
end

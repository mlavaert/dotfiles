local awful = require("awful")
local gears = require("gears")


local tags = {
  {
    icon="",
    type = "browser",
    defaultApp = "firefox",
    screen = 1
  },
  {
    icon="",
    type = "code",
    defaultApp = "emacs",
    screen = 1
  },
  {
    icon="3",
    type = "music",
    defaultApp = "spotify",
    screen = 2
  },
  {
    icon="4",
    type = "chat",
    defaultApp = "slack",
    screen = 2
  }
}

awful.layout.layouts = {
  awful.layout.suit.tile,
  awful.layout.suit.max
}

awful.screen.connect_for_each_screen(
  function(screen)
    for i, tag in pairs(tags) do
      awful.tag.add(
        i,
        {
          icon = tag.icon,
          icon_only = true,
          layout = awful.layout.suit.tile,
          gap_single_client = false,
          gap = 4,
          screen = screen,
          defaultApp = tag.defaultApp,
          selected = i == 1
        }
      )
    end
  end
)

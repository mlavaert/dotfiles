local awful = require("awful")
local gears = require("gears")

local icons = require('theme.icons')
local apps = require('configuration.apps')

local tags = {
  {
    icon = icons.chrome,
    type = 'browser',
    defaultApp = apps.default.browser,
    screen = 2
  },
  {
    icon = icons.code,
    type = 'code',
    defaultApp = apps.default.editor,
    screen = 2
  },
  {
    icon = icons.social,
    type = 'social',
    defaultApp = 'slack',
    screen = 1
  },
  {
    icon = icons.folder,
    type = 'files',
    defaultApp = 'pcmanfm',
    screen = 1
  },
  {
    icon = icons.music,
    type = 'music',
    defaultApp = 'env com.spotify.Client',
    screen = 1
  },
  {
    icon = icons.game,
    type = 'game',
    defaultApp = '',
    screen = 1
  },
  {
    icon = icons.lab,
    type = 'any',
    defaultApp = '',
    screen = 1
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
            icon_only = false,
            layout = awful.layout.suit.tile,
            gap_single_client = false,
            gap = 8,
            screen = screen,
            defaultApp = tag.defaultApp,
            selected = i == 1
            }
        )
    end
  end
)

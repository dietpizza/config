-----------------------------
-- Solarized awesome theme --
-----------------------------

-- local theme_assets = require("beautiful.theme_assets")

local theme = {}

theme.wallpaper = "~/wall/debianish.png"

theme.font = "Terminus 9"

theme.useless_gap   = 5
theme.border_width  = 1

-- Solarized colors
theme.base03   = "#002b36"
theme.base02   = "#073642"
theme.base01   = "#586e75"
theme.base00   = "#657b83"
theme.base0    = "#839496"
theme.base1    = "#93a1a1"
theme.base2    = "#eee8d5"
theme.base3    = "#fdf6e3"
theme.yellow   = "#b58900"
theme.orange   = "#cb4b16"
theme.red      = "#dc322f"
theme.magenta  = "#d33682"
theme.violet   = "#6c71c4"
theme.blue     = "#268bd2"
theme.cyan     = "#288198"
theme.green    = "#859900"
theme.oldfocus = "#2aa198"

-- Normal colors
theme.bg_normal     = theme.base03
theme.fg_normal     = theme.base1
theme.border_normal = theme.base02

-- Focused colors
theme.bg_focus      = theme.oldfocus
theme.fg_focus      = theme.base03
theme.border_focus  = theme.blue

-- Urgent colors
theme.bg_urgent     = theme.red
theme.fg_urgent     = theme.base03

-- minimized colors
theme.bg_minimize   = theme.base01
theme.fg_minimize   = theme.base03

-- Border colors
theme.border_marked = theme.yellow

-- Systray colors
theme.bg_systray    = theme.bg_normal

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]

theme.taglist_fg_focus      = theme.base3
theme.taglist_bg_focus      = theme.blue
theme.taglist_fg_occupied   = theme.base2
theme.titlebar_bg_focus     = theme.blue
theme.titlebar_fg_focus     = theme.base3

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

theme.notification_border_color = theme.blue

theme.icon_theme = nil

return theme

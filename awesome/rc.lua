-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

local autostart = true

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
  naughty.notify({ preset = naughty.config.presets.critical,
    title = "Oops, there were errors during startup!",
    text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
  local in_error = false
  awesome.connect_signal("debug::error", function (err)
    -- Make sure we don't go into an endless error loop
    if in_error then return end
    in_error = true

    naughty.notify({ preset = naughty.config.presets.critical,
      title = "Oops, an error happened!",
      text = tostring(err) })
    in_error = false
  end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init(awful.util.getdir("config").."/solarized.lua")
local pulseaudio = require("pulseaudio")
beautiful.notification_max_width = 350
beautiful.notification_icon_size = 72

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"
alt = "Mod1"
-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
  -- awful.layout.suit.floating,
  awful.layout.suit.tile
  -- awful.layout.suit.tile.left,
  -- awful.layout.suit.tile.bottom,
  -- awful.layout.suit.tile.top,
  -- awful.layout.suit.fair,
  -- awful.layout.suit.fair.horizontal,
  -- awful.layout.suit.spiral,
  -- awful.layout.suit.spiral.dwindle,
  -- awful.layout.suit.max,
  -- awful.layout.suit.max.fullscreen,
  -- awful.layout.suit.magnifier,
  -- awful.layout.suit.corner.nw,
  -- awful.layout.suit.corner.ne,
  -- awful.layout.suit.corner.sw,
  -- awful.layout.suit.corner.se,
}
-- }}}

-- {{{ Wibar
-- Create a textclock widget
mytextclock = wibox.widget.textclock (" %a %d-%m-%y %H:%M:%S ",1)

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
  awful.button({ }, 1, function(t) t:view_only() end),
  awful.button({ modkey }, 1, function(t)
      if client.focus then
        client.focus:move_to_tag(t)
      end
    end),
  awful.button({ }, 3, awful.tag.viewtoggle),
  awful.button({ modkey }, 3, function(t)
      if client.focus then
        client.focus:toggle_tag(t)
      end
    end),
  awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
  awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)

local function set_wallpaper(s)
  -- Wallpaper
  if beautiful.wallpaper then
    local wallpaper = beautiful.wallpaper
    -- If wallpaper is a function, call it with the screen
    if type(wallpaper) == "function" then
      wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)
  end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
  -- Wallpaper
  set_wallpaper(s)

  -- Each screen has its own tag table.
  awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8" }, s, awful.layout.layouts[1])

  -- Create a taglist widget
  s.mytaglist = awful.widget.taglist {
    screen  = s,
    filter  = awful.widget.taglist.filter.all,
    buttons = taglist_buttons,
    widget_template = {
      {
        {
          {
              id     = 'text_role',
              widget = wibox.widget.textbox,
          },
          layout = wibox.layout.fixed.horizontal,
        },
        left  = 6,
        right = 5,
        widget = wibox.container.margin
      },
      id     = 'background_role',
      widget = wibox.container.background,
    },
  }

  -- Create the wibox
  s.mywibox = awful.wibar({ position = "top", screen = s, height = 20 })

  -- Add widgets to the wibox
  s.mywibox:setup {
    layout = wibox.layout.align.horizontal,
    { -- Left widgets
      layout = wibox.layout.fixed.horizontal,
      s.mytaglist,
    },
    { -- Middle widgets
      layout = wibox.layout.fixed.horizontal,
    },
    { -- Right widgets
      layout = wibox.layout.fixed.horizontal,
      pulseaudio,
      mytextclock,
      wibox.widget.systray(),
    },
  }
end)
-- }}}

-- {{{ Key bindings
globalkeys = gears.table.join(
  awful.key({ modkey, }, "Left",   awful.tag.viewprev,
    {description = "view previous", group = "tag"}),
  awful.key({ modkey, }, "Right",  awful.tag.viewnext,
    {description = "view next", group = "tag"}),
  awful.key({ modkey, }, "Escape", awful.tag.history.restore,
    {description = "go back", group = "tag"}),
  awful.key({ modkey, }, "Tab",
    function ()
      awful.client.focus.byidx( 1 )
    end,
    {description = "focus next by index", group = "client"}
  ),
  -- Standard program
  awful.key({ modkey, "Control" }, "r", awesome.restart,
    {description = "reload awesome", group = "awesome"}),
  awful.key({ modkey, "Control" }, "q", awesome.quit,
    {description = "quit awesome", group = "awesome"}),
  -- Resize
  awful.key({ modkey, "Control" }, "Right", function () awful.tag.incmwfact( 0.01) end),
  awful.key({ modkey, "Control" }, "Left", function () awful.tag.incmwfact(-0.01) end),
  -- Custom keybindings
  awful.key({ modkey, }, "Return", function(args) awful.util.spawn('alacritty') end),
  awful.key({ modkey, }, "l",      function(args) awful.util.spawn('dmenu_run') end),
  awful.key({ modkey, }, "b",      function(args) awful.util.spawn('google-chrome-stable') end),
  awful.key({ modkey, }, "k",      function(args) awful.util.spawn('code') end),
  awful.key({ modkey, }, "f",      function(args) awful.util.spawn('caja') end),
  awful.key({ modkey, }, "s",      function(args) awful.util.spawn('scrot') end),
  awful.key({ modkey, }, "m",      function(args) awful.util.spawn('alacritty -e cmus') end),
  awful.key({ modkey, }, "o",      function(args) awful.util.spawn('alacritty -e ranger') end),
  awful.key({ modkey, }, "i",      function(args) awful.util.spawn_with_shell('~/.config/.bin/launch.sh') end),
  awful.key({ modkey, }, "p",      function(args) awful.util.spawn_with_shell('~/.config/.bin/power.sh') end),
  awful.key({ modkey, }, "Up",     pulseaudio.volume_up ),
  awful.key({ modkey, }, "Down",   pulseaudio.volume_down )
)

clientkeys = gears.table.join(
  awful.key({ modkey, "Control" }, "f",
    function (c)
      c.fullscreen = not c.fullscreen
      c:raise()
    end,
    {description = "toggle fullscreen", group = "client"}),
  awful.key({ alt, }, "q", function (c) c:kill() end,
    {description = "close", group = "client"}),
  awful.key({ modkey, }, "space",  awful.client.floating.toggle,
    {description = "toggle floating", group = "client"}),
  awful.key({ modkey, }, "m", function (c) c:swap(awful.client.getmaster()) end,
    {description = "move to master", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
  globalkeys = gears.table.join(globalkeys,
    -- View tag only.
    awful.key({ modkey }, "#" .. i + 9,
      function ()
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
           tag:view_only()
        end
      end,
      {description = "view tag #"..i, group = "tag"}
    ),
    -- Move client to tag.
    awful.key({ alt, }, "#" .. i + 9,
      function ()
        if client.focus then
          local tag = client.focus.screen.tags[i]
          if tag then
            client.focus:move_to_tag(tag)
          end
       end
      end,
      {description = "move focused client to tag #"..i, group = "tag"}
    )
  )
end

clientbuttons = gears.table.join(
  awful.button({ }, 1, 
    function (c)
      c:emit_signal("request::activate", "mouse_click", {raise = true})
    end
  ),
  awful.button({ modkey }, 1, 
    function (c)
      c:emit_signal("request::activate", "mouse_click", {raise = true})
      awful.mouse.client.move(c)
    end
  ),
  awful.button({ modkey }, 3, 
    function (c)
      c:emit_signal("request::activate", "mouse_click", {raise = true})
      awful.mouse.client.resize(c)
    end
  )
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
  -- All clients will match this rule.
  { rule = { },
    properties = { 
      border_width = beautiful.border_width,
      border_color = beautiful.border_normal,
      focus = awful.client.focus.filter,
      raise = true,
      keys = clientkeys,
      buttons = clientbuttons,
      screen = awful.screen.preferred,
      placement = awful.placement.no_overlap + awful.placement.no_offscreen
   }
  },

  -- Add titlebars to normal clients and dialogs
  { rule_any = {type = { "normal", "dialog" }
    }, properties = { titlebars_enabled = false }
  },

  -- Bind cients to tags
  { rule = { class = "Uget-gtk" }, properties = { tag = "8" } },
  { rule = { class = "qBittorrent" }, properties = { tag = "7" } },
  -- { rule = { name = "win0" }, properties = { floating = true } },
  -- { rule = { name = "jetbrains-studio" }, properties = { floating = true } },
  { rule = { 
    class = "jetbrains-studio", name="^win[0-9]+$" },
    properties = { placement = awful.placement.no_offscreen, floating = true 
  } },
  { rule = { 
    class = "vlc" },
    properties = { placement = awful.placement.no_offscreen, floating = true 
  } },
}
-- }}}

-- {{{ Autostart
if autostart == true then
  awesome.connect_signal(
    'exit',
    function(args)
      awful.util.spawn_with_shell('~/.config/.bin/cleanup.sh')
    end
  )

  awesome.connect_signal(
    'startup',
    function(args)
      awful.util.spawn_with_shell('~/.config/.bin/autostart.sh')
    end
  )
end
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.

client.connect_signal("manage", function (c)
  -- Set the windows at the slave,
  -- i.e. put it at the end of others instead of setting it master.
  if not awesome.startup then awful.client.setslave(c) end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
  -- buttons for the titlebar
  local buttons = gears.table.join(
    awful.button({ }, 1, function()
      c:emit_signal("request::activate", "titlebar", {raise = true})
      awful.mouse.client.move(c)
    end),
    awful.button({ }, 3, function()
      c:emit_signal("request::activate", "titlebar", {raise = true})
      awful.mouse.client.resize(c)
    end)
  )

  awful.titlebar(c) : setup {
    { -- Left
      -- awful.titlebar.widget.iconwidget(c),
      buttons = buttons,
      layout  = wibox.layout.fixed.horizontal
    },
    { -- Middle
      { -- Title
        align  = "center",
        widget = awful.titlebar.widget.titlewidget(c)
      },
      buttons = buttons,
      layout  = wibox.layout.flex.horizontal
    },
    { -- Right
      awful.titlebar.widget.closebutton(c),
      layout = wibox.layout.fixed.horizontal()
    },
    layout = wibox.layout.align.horizontal
  }
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- disable startup-notification globally
local oldspawn = awful.util.spawn
awful.util.spawn = function (s)
  oldspawn(s, false)
end
-- }}}

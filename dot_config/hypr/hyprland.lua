hl.monitor({
    output = "eDP-1",
    mode = "highres",
    position = "0x0",
    scale = "auto",
})

hl.monitor({
    output = "HDMI-A-1",
    mode = "highres",
    position = "0x0",
    scale = "auto",
})

hl.on("hyprland.start", function()
        hl.exec_cmd("hyprpaper")
        hl.exec_cmd("hyprpm reload -n")
        hl.exec_cmd("redshift -l 39.86804:-104.97192")
        hl.exec_cmd("waybar")
end)

hl.env("GDK_SCALE", "2")
hl.env("XCURSOR_SIZE", "32")
hl.env("HYPRCURSOR_SIZE", "24")

hl.config({
    general = {
      gaps_in = 5,
      gaps_out = 20,
      
      border_size = 2,
      
      col = {
        active_border = {
          colors = {
            "rgb(bd93f9)", "rgb(f892c6)"
          },
          angle = 45,
        },
        inactive_border = "rgba(44475aaa)",
        nogroup_border = "rgba(282a36dd)",
        nogroup_border_active = {
          colors = {
            "rgb(bd93f9)", "rgb(f892c6)"
          },
          angle = 45,
        },
      },
      
      allow_tearing = false,
      
      layout = hy3,
    },
})

hl.config({
    decoration = {
      rounding = 10,
      
      active_opacity = 1.0,
      inactive_opacity = 1.0,
      
      shadow = {
        enabled = true,
        range = 4,
        render_power = 3,
        color = "rgba(1a1a1aee)",
      },
      
      blur = {
        enabled = true,
        size = 3,
        passes = 1,
        vibrancy = 0.1696,
      },
    },
})

hl.config({
    animations = {
      enabled = true,
    },
})

hl.curve("myBezier", {
    type = "bezier",
    points = { {0.05, 0.9}, {0.1, 1.05} },
})

hl.animation({ leaf = "windows", enabled = true, speed = 7, bezier = "myBezier" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 7, bezier = "default", style = "popin 80%" })
hl.animation({ leaf = "border", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 8, bezier = "default" })
hl.animation({ leaf = "fade", enabled = true, speed = 7, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 6, bezier = "default" })

hl.config({
    dwindle = {
      preserve_split = true, -- You probably want this
    },
})

hl.config({
    master = {
      new_status = "master", -- or 1? or true?
    },
})

hl.config({
    misc = {
      force_default_wallpaper = -1, -- Set to 0 or 1 to disable the anime mascot wallpapers
      disable_hyprland_logo = false, -- If true disables the random hyprland logo / anime girl background. :(
    },
})

hl.config({
    input = {
      kb_layout = "us",
      kb_variant = "",
      kb_model = "",
      kb_options = "",
      kb_rules = "",

      follow_mouse = 1,
      
      sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.
      touchpad = {
        natural_scroll = false,
      },
    },
})

hl.device({
    name = "epic-mouse-v1",
    sensitivity = -0.5,
})

local suppressMaximizeRule = hl.window_rule({
   name = "suppress-maximize-events",
   match = {
     class = ".*",
   },
   suppress_event = "maximize",
})

hl.window_rule({
    name = "xwayland-video-bridge-fixes",
    match = {
      class = "xwaylandvideobridge",
    },
    
    no_initial_focus = true,
    no_focus = true,
    no_anim = true,
    no_blur = true,
    max_size = {1,1},
    opacity = 0.0,
})

require("./binds.lua")

local vars = require("lua.variables")

-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function () 
  hl.exec_cmd('hyprctl setcursor Bibata-Modern-Ice 24')
  hl.exec_cmd("xrdb -merge ~/.Xresources")
  hl.exec_cmd("uwsm app -- ".. vars.browser)
end)

----------------
----  MISC  ----
----------------

hl.config({
    misc = {
        force_default_wallpaper = -1,    -- Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo   = false, -- If true disables the random hyprland logo / anime girl background. :(
    },
})

-----------------
--- XWAYLAND ----
-----------------

hl.config({
  xwayland = {
    force_zero_scaling = true
  }
})

local vars = require("lua.variables")

---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout  = "us",
        kb_variant = "",
        kb_model   = "",
        kb_options = "",
        kb_rules   = "",

        follow_mouse = 1,

        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

        touchpad = {
            natural_scroll = true,
            scroll_factor  = 0.75,
            clickfinger_behavior = true,
            tap_to_click = false,
        },

        tablet = {
            output = "DP-1",
            region_position = "320 50", -- horizontally centered, vertically aligned top with 50px margin
            region_size = "1920 1200", -- UGEE M808 with 16:10 aspect ratio

	},
    },
})

-----------------
--- Gestures ----
-----------------

hl.gesture({
    fingers = 3,
    direction = "swipe",
    action = "move"
})

hl.gesture({
    fingers = 3,
    direction = "swipe",
    mods = "SUPER",
    action = "resize"
})

hl.gesture({
    fingers = 4,
    direction = "horizontal",
    action = "workspace"
})

hl.gesture({
    fingers = 4,
    direction = "down",
    action = "close"
})

hl.gesture({
    fingers = 4,
    direction = "up",
    action = function()
        hl.exec_cmd(vars.menu)
    end
})

hl.gesture({
    fingers = 4,
    direction = "pinchout",
    action = "float",
    mode = "float"
})

hl.gesture({
    fingers = 4,
    direction = "pinchin",
    action = "float",
    mode = "tile"
})
-- Example per-device config
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/ for more
hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})

---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
hl.bind(mainMod .. " + Space", hl.dsp.exec_cmd(vars.menu))
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd("uwsm app -- " .. vars.terminal))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("uwsm app -- " .. vars.fileManager))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("uwsm app -- " .. vars.browser))
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd("uwsm app -- " .. vars.secondary_browser))

hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + bracketright", hl.dsp.layout("togglesplit"))    -- dwindle only
hl.bind(mainMod .. " + bracketleft", hl.dsp.layout("swapsplit"))    -- dwindle only
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.layout("movetoroot"))    -- dwindle only

-- Move focus with mainMod + hjkl keys
hl.bind(mainMod .. " + H",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J",  hl.dsp.focus({ direction = "down" }))

-- Move active window with mainMod + SHIFT + hjkl keys
hl.bind(mainMod .. " + SHIFT + H",  hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + K",    hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + J",  hl.dsp.window.move({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

hl.bind(mainMod .. " + Tab", hl.dsp.exec_cmd("rofi -show window"))
-- To switch between windows in a floating workspace:
hl.bind("ALT + Tab", function()
    hl.dispatch(hl.dsp.window.cycle_next())    -- Change focus to another window
    hl.dispatch(hl.dsp.window.bring_to_top()) -- Bring it to the top
end)

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Switch to a submap called `resize`.
hl.bind(mainMod .. " + R", hl.dsp.submap("resize"))

-- Start a submap called "resize".
hl.define_submap("resize", function()

    -- Set repeating binds for resizing the active window.
    hl.bind("L", hl.dsp.window.resize({ x = 10, y = 0, relative = true}), { repeating = true })
    hl.bind("H", hl.dsp.window.resize({ x = -10, y = 0, relative = true}), { repeating = true })
    hl.bind("K", hl.dsp.window.resize({ x = 0, y = 10, relative = true}), { repeating = true })
    hl.bind("J", hl.dsp.window.resize({ x = 10, y = -10, relative = true}), { repeating = true })

    -- Use `reset` to go back to the global submap
    hl.bind("catchall", hl.dsp.submap("reset"))

end)

hl.bind(mainMod .. " + C", hl.dsp.exec_cmd("hyprshot -m active -m output -o ~/Pictures/screenshots"))
-- Switch to a submap called "screencapture".
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.submap("screencapture"))

-- Start a submap called "screencapture".
hl.define_submap("screencapture", function()
    hl.bind("R", function()
        hl.dsp.exec_cmd("hyprshot -m region -o ~/Pictures/screenshots")
        hl.dsp.submap("reset")
    end)
    hl.bind("W", function()
        hl.dsp.exec_cmd("hyprshot -m window -o ~/Pictures/screenshots")
        hl.dsp.submap("reset")
    end)
    hl.bind("O", function()
        hl.dsp.exec_cmd("hyprshot -m output -o ~/Pictures/screenshots")
        hl.dsp.submap("reset")
    end)
    hl.bind("catchall", hl.dsp.submap("reset"))
end)

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

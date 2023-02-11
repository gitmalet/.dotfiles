# -*- coding: utf-8 -*-

import os
import re
import socket
import subprocess
from libqtile import backend, bar, layout, widget, qtile, hook
from libqtile.config import Click, Drag, Group, KeyChord, Key, Match, Screen
from libqtile.command import lazy
from libqtile.backend.wayland import InputConfig

mod = "mod4"
terminal = "alacritty"
browser = "firefox"

keys = [
    Key([mod], "Return", lazy.spawn(terminal), desc="Terminal"),
    Key([mod], "b", lazy.spawn(browser), desc="Browser"),
    Key([mod], "Space", lazy.spawn("rofi -show combi -combi-modes window,run,ssh -sort"), desc="App and Window Launcher"),
    Key([mod], "d", lazy.spawn("rofi -show run -sort"), desc="App Launcher"),
    Key([mod], "q", lazy.spawn("physlock -s"), desc="Lock screen"),
    Key([mod, "shift"], "q", lazy.window.kill(), desc="Close focused window"),
    Key([mod, "shift"], "r", lazy.reload_config(), desc="Reload configuration"),
    Key([mod, "shift"], "e", lazy.shutdown(), desc="Close Qtile"),

    Key([], "XF86AudioMute", lazy.spawn(
        "pactl set-sink-mute @DEFAULT_SINK@ toggle")),
    Key([], "XF86AudioLowerVolume", lazy.spawn(
        "pactl set-sink-volume @DEFAULT_SINK@ -1000")),
    Key([], "XF86AudioRaiseVolume", lazy.spawn(
        "pactl set-sink-volume @DEFAULT_SINK@ +1000")),
    Key([], "XF86AudioPlay", lazy.spawn("playerctl play-pause")),
    Key([], "XF86AudioNext", lazy.spawn("playerctl next")),
    Key([], "XF86AudioPrev", lazy.spawn("playerctl previous")),
    Key([], "XF86AudioStop", lazy.spawn("playerctl stop")),

    Key([mod], "Tab",
        lazy.next_layout(),
        desc="Toggle between layouts"
        ),
    Key([mod, "shift"], "Tab",
        lazy.layout.flip(),
        desc="Toggle between layouts"
        ),
    Key([mod], "w",
        lazy.window.kill(),
        desc="Kill focused window"
        ),
    Key([mod, "control"], "r",
        lazy.restart(),
        desc="Restart Qtile"
        ),
    Key([mod, "control"], "q",
        lazy.shutdown(),
        desc="Shutdown Qtile"
        ),

    # Moving around
    Key([mod], "h",
        lazy.layout.left(),
        desc="Move focus to left"
        ),
    Key([mod], "l",
        lazy.layout.right(),
        desc="Move focus to right"
        ),
    Key([mod], "j",
        lazy.layout.down(),
        desc="Move focus down"
        ),
    Key([mod], "k",
        lazy.layout.up(),
        desc="Move focus up"
        ),
    Key([mod], "Left",
        lazy.layout.left(),
        desc="Move focus to left"
        ),
    Key([mod], "Right",
        lazy.layout.right(),
        desc="Move focus to right"
        ),
    Key([mod], "Down",
        lazy.layout.down(),
        desc="Move focus down"
        ),
    Key([mod], "Up",
        lazy.layout.up(),
        desc="Move focus up"
        ),

    # Move focused window
    Key([mod, "shift"], "h",
        lazy.layout.shuffle_left(),
        desc="Move window left"
        ),
    Key([mod, "shift"], "l",
        lazy.layout.shuffle_right(),
        desc="Move window right"
        ),
    Key([mod, "shift"], "j",
        lazy.layout.shuffle_down(),
        desc="Move window down"
        ),
    Key([mod, "shift"], "k",
        lazy.layout.shuffle_up(),
        desc="Move window up"
        ),
    Key([mod, "shift"], "Left",
        lazy.layout.shuffle_left(),
        desc="Move window left"
        ),
    Key([mod, "shift"], "Right",
        lazy.layout.shuffle_right(),
        desc="Move window right"
        ),
    Key([mod, "shift"], "Down",
        lazy.layout.shuffle_down(),
        desc="Move window down"
        ),
    Key([mod, "shift"], "Up",
        lazy.layout.shuffle_up(),
        desc="Move window up"
        ),

    # Resize windows
    Key([mod, "control"], "h",
        lazy.layout.grow_left(),
        desc="Grow window left"
        ),
    Key([mod, "control"], "l",
        lazy.layout.grow_right(),
        desc="Grow window right"
        ),
    Key([mod, "control"], "j",
        lazy.layout.grow_down(),
        desc="Grow window down"
        ),
    Key([mod, "control"], "k",
        lazy.layout.grow_up(),
        desc="Grow window up"
        ),
    Key([mod], "n",
        lazy.layout.normalize(),
        desc="Reset all window sizes"
        ),
    Key([mod], "m",
        lazy.layout.maximize(),
        desc="Maximize current window sizes"
        ),
    Key([mod, "control"], "Left",
        lazy.layout.grow_left(),
        desc="Grow window left"
        ),
    Key([mod, "control"], "Right",
        lazy.layout.grow_right(),
        desc="Grow window right"
        ),
    Key([mod, "control"], "Down",
        lazy.layout.grow_down(),
        desc="Grow window down"
        ),
    Key([mod, "control"], "Up",
        lazy.layout.grow_up(),
        desc="Grow window up"
        ),

    Key([mod, "shift"], "Space",
        lazy.window.toggle_floating(),
        desc="Toggle floating of window"
        ),


    ### Switch focus to specific monitor (out of three)
    KeyChord([mod], "s", [
        Key([], str(d), lazy.to_screen(d-1), desc='Focus to monitor {}'.format(d))
        for d in range(1, 10)
    ], name="Screen Mode"),
]

wl_input_rules = {
    "type:keyboard": InputConfig(kb_layout="us,de", kb_variant="euro", kb_options="caps:escape,compose:ralt")
}

groups = [Group(str(i)) for i in range(1,10)]

for (i, g) in enumerate(groups):
    keys.extend(
        [
            # mod + letter of group = switch to group
            Key(
                [mod],
                str(i+1),
                lazy.group[g.name].toscreen(),
                desc="Switch to group {}".format(g.name),
            ),
            # mod + shift + letter of group = switch to & move focused window to group
            Key(
                [mod, "shift"],
                str(i+1),
                lazy.window.togroup(g.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(g.name),
            ),
            # Or, use below if you prefer not to switch to that group.
            # # mod1 + shift + letter of group = move focused window to group
            # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            #     desc="move focused window to group {}".format(i.name)),
        ]
    )

def load_colors(xresources):
    pattern = r'#define base[0-9a-fA-f]+ (#[0-9a-fA-F]*)'
    with open(xresources, 'r', encoding="utf-8") as file:
        for match in re.findall(pattern, file.read()):
            yield match

resources=os.path.expanduser('~/.Xresources')
colors = list(load_colors(resources)) + ['#ffffff']

layout_theme = {"border_width": 1,
                "margin": 0,
                "border_focus": colors[14],
                "border_normal": colors[0],
                }


layouts = [
    layout.Columns(**layout_theme),
    layout.Max(**layout_theme),
    layout.MonadWide(ratio=0.75, **layout_theme),
    layout.MonadTall(ratio=0.65, **layout_theme),
    layout.Floating(**layout_theme),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]


widget_defaults = dict(
    font="SauceCodePro Nerd Font",
    fontsize=13,
    padding=5,
    foreground = colors[5],
)
extension_defaults = widget_defaults.copy()

number_of_displays = 4

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.CurrentLayout(),
                widget.GroupBox(
                    active = colors[7],
                    inactive = colors[3],
                    this_current_screen_border = colors[14],
                    this_screen_border = colors[0],
                    other_current_screen_border = colors[14],
                    other_screen_border = colors[0],

                ),
                widget.Prompt(),
                widget.WindowName(),
                widget.Chord(),
                widget.CPU(),
                widget.Sep(),
                widget.Memory(fmt="Memory: {}", measure_mem="G"),
                widget.DF(fmt="Disk: {}", visible_on_warn=False),
                widget.Net(fmt="Network: {}"),
                widget.PulseVolume(fmt="Volume: {}"),
                # NB Systray is incompatible with Wayland, consider using StatusNotifier instead
                # widget.StatusNotifier(),
                widget.Systray(),
                widget.Clock(format="%Y-%m-%d %a %H:%M"),
            ],
            24,
            background=colors[0]
            # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
            # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
        ),
    ) for _ in range(number_of_displays)
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"

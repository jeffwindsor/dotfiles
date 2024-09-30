
from libqtile import bar, layout, qtile, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

m1, m2, mm = "alt", "control", "shift"
mod1, mod1m = [m1], [m1, mm]
mod2, mod2m = [m1, m2], [m1, m2, mm]

groups = [Group(i) for i in "1234567890acmnostuy"]
terminal = guess_terminal()

# https://docs.qtile.org/en/latest/manual/config/lazy.html#special-keys
keys = [
    # Launchers
    Key(mod1, "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
    Key(mod2, "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key(mod2, "a", lazy.spawn(slack), desc="Launch slack"),
    Key(mod2, "b", lazy.spawn(firefox), desc="Launch firefox"),
    Key(mod2, "c", lazy.spawn(calendar), desc="Launch calendar"),
    Key(mod2, ",", lazy.spawn(settings), desc="Launch settings"),
    Key(mod2, "f", lazy.spawn(firefox), desc="Launch firefox"),
    Key(mod2, "m", lazy.spawn(messages), desc="Launch messages"),
    Key(mod2, "n", lazy.spawn(notes), desc="Launch notes"),
    Key(mod2, "o", lazy.spawn(outlook), desc="Launch outlook"),
    Key(mod2, "s", lazy.spawn(spotify), desc="Launch spotify"),
    # Key(mod2, "space", lazy.spawn(home folder), desc="Launch home folder"),
    # Key(mod2, "t", lazy.spawn(teams), desc="Launch teams"),
    Key(mod2, "v", lazy.spawn(zsh nvim), desc="Launch neovim"),
    Key(mod2, "y", lazy.spawn(zsh yazi), desc="Launch file manager"),

    # System
    Key(mod1m, "r", lazy.reload_config(), desc="Reload the config"),
    Key(mod1m, "q", lazy.shutdown(), desc="Shutdown Qtile"),

    # Windows
    Key(mod1, "w", lazy.window.kill(), desc="Kill focused window"),
    Key(mod1, "f", lazy.window.toggle_fullscreen(), desc="Toggle window fullscreen"),
    Key(mod1m, "f", lazy.window.toggle_floating(), desc="Toggle window floating"),
    Key(mod1, "h", lazy.layout.left(), desc="Focus window left"),
    Key(mod1, "l", lazy.layout.right(), desc="Focus window right"),
    Key(mod1, "j", lazy.layout.down(), desc="Focus window down"),
    Key(mod1, "k", lazy.layout.up(), desc="Focus window up"),
    Key(mod1m, "Return", lazy.layout.toggle_split(), desc="Focus Master/Stack"),
    Key(mod1m, "h", lazy.layout.shuffle_left(), desc="Move window left"),
    Key(mod1m, "l", lazy.layout.shuffle_right(), desc="Move window right"),
    Key(mod1m, "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key(mod1m, "k", lazy.layout.shuffle_up(), desc="Move window up"),
    Key(mod1, "=", lazy.layout.increase_ratio(), desc="Increase Master Ratio"),
    Key(mod1, "-", lazy.layout.decrease_ratio(), desc="Decrease Master Ratio"),
    Key(mod1, "n", lazy.layout.normalize(), desc="Reset all window sizes"),
]

# Focus Workspace / Group
keys.extend([Key( mod1, i.name, lazy.group[i.name].toscreen(), desc=f"Switch to group {i.name}",) for i in groups])

# Move Window and Focus Workspace / Group
keys.extend(Key( [mod, "shift"], i.name, lazy.window.togroup(i.name, switch_group=True), desc=f"Switch to & move focused window to group {i.name}",) for i in groups])

layouts = [
    layout.Columns(border_focus_stack=["#d75f5f", "#8f3d3d"], border_width=4),
    layout.Max(),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.MonadTall(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

widget_defaults = dict(
    font="sans",
    fontsize=12,
    padding=3,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        bottom=bar.Bar(
            [
                widget.CurrentLayout(),
                widget.GroupBox(),
                widget.Prompt(),
                widget.WindowName(),
                widget.Chord(
                    chords_colors={
                        "launch": ("#ff0000", "#ffffff"),
                    },
                    name_transform=lambda name: name.upper(),
                ),
                widget.TextBox("default config", name="default"),
                widget.TextBox("Press &lt;M-r&gt; to spawn", foreground="#d75f5f"),
                # NB Systray is incompatible with Wayland, consider using StatusNotifier instead
                # widget.StatusNotifier(),
                widget.Systray(),
                widget.Clock(format="%Y-%m-%d %a %I:%M %p"),
                widget.QuickExit(),
            ],
            24,
            # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
            # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
        ),
        # You can uncomment this variable if you see that on X11 floating resize/moving is laggy
        # By default we handle these events delayed to already improve performance, however your system might still be struggling
        # This variable is set to None (no cap) by default, but you can set it to 60 to indicate that you limit it to 60 events per second
        # x11_drag_polling_rate = 60,
    ),
]

# Drag floating layouts.
mouse = [
    Drag(mod1, "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag(mod1, "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click(mod1, "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
floats_kept_above = True
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

# xcursor theme (string or None) and size (integer) for Wayland backend
wl_xcursor_theme = None
wl_xcursor_size = 24

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"

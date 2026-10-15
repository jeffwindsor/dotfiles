# Kitty key bindings

Effective macOS bindings for Kitty 0.49.2: Kitty defaults plus the overrides in `kitty.conf`.

- `kitty_mod` is `ctrl+shift` (the Kitty default), so `kitty_mod+l` is written `ctrl+shift+l`.
- **override** means the binding comes from `kitty.conf` and replaces or adds to the default.
- **default** means it is Kitty's built-in binding.
- `a then b` is a chord: press `a`, release, then press `b`.
- Mouse bindings are not listed.

## Windows (panes in a tab)

| Action | Shortcut | Source |
| ------ | -------- | ------ |
| New window (same cwd) | `cmd+enter` | override |
| New window | `ctrl+shift+enter` | default |
| New OS window | `cmd+n`, `ctrl+shift+n` | default |
| Close window | `cmd+shift+d`, `ctrl+shift+w` | default |
| Focus neighbor left / right / up / down | `cmd+left` / `right` / `up` / `down` | override |
| Focus next window | `ctrl+shift+]` | default |
| Focus previous window | `ctrl+shift+[` | default |
| Focus Nth window (1-9) | `cmd+1` ... `cmd+9`, `ctrl+shift+1` ... `ctrl+shift+9` | default |
| Focus 10th window | `ctrl+shift+0` | default |
| Focus window by hint | `ctrl+shift+f7` | default |
| Move window left / right / up / down | `cmd+shift+left` / `right` / `up` / `down` | override |
| Move window forward in order | `ctrl+shift+f` | default |
| Move window backward in order | `ctrl+shift+b` | default |
| Move window to top (main slot) | ``ctrl+shift+` `` | default |
| Swap with a window picked by hint | `ctrl+shift+f8` | default |
| Resize mode | `cmd+r`, `ctrl+shift+r` | default |

Directional moves only act when there is a neighbor in that direction. For example, up and down do nothing in `horizontal`, and nothing moves in `stack`.

Resize mode keys: `w` wider, `n` narrower, `t` taller, `s` shorter, `r` reset, `esc` or `q` to exit.

## Layouts

Enabled layouts (cycle order): `tall`, `horizontal`, `vertical`, `stack`.

| Action | Shortcut | Source |
| ------ | -------- | ------ |
| Cycle to next layout | `ctrl+shift+l` | default |
| Toggle full-size (`stack`) and back | `cmd+shift+f` | override |

Layout behavior:
- `tall`: one main window on the left, the rest stacked on the right.
- `horizontal`: all windows side by side.
- `vertical`: all windows stacked.
- `stack`: one window fills the tab.

## Tabs

| Action | Shortcut | Source |
| ------ | -------- | ------ |
| New tab (blank title) | `cmd+t` | override |
| New tab | `ctrl+shift+t` | default |
| Close tab | `cmd+w`, `ctrl+shift+q` | default |
| Close OS window | `cmd+shift+w` | default |
| Next tab | `cmd+]` | override |
| Next tab | `shift+cmd+]`, `ctrl+tab`, `ctrl+shift+right` | default |
| Previous tab | `cmd+[` | override |
| Previous tab | `shift+cmd+[`, `ctrl+shift+tab`, `ctrl+shift+left` | default |
| Move tab forward | `ctrl+shift+.` | default |
| Move tab backward | `ctrl+shift+,` | default |
| Rename tab (clears the current name first) | `cmd+shift+i` | override |
| Rename tab (prompt) | `ctrl+shift+alt+t` | default |

## Scrolling and search

| Action | Shortcut | Source |
| ------ | -------- | ------ |
| Scroll line up | `ctrl+shift+up`, `ctrl+shift+k`, `opt+cmd+page_up` | default |
| Scroll line down | `ctrl+shift+down`, `ctrl+shift+j`, `opt+cmd+page_down` | default |
| Scroll page up | `ctrl+shift+page_up`, `cmd+page_up` | default |
| Scroll page down | `ctrl+shift+page_down`, `cmd+page_down` | default |
| Scroll to top | `ctrl+shift+home`, `cmd+home` | default |
| Scroll to bottom | `ctrl+shift+end`, `cmd+end` | default |
| Previous shell prompt | `ctrl+shift+z` | default |
| Next shell prompt | `ctrl+shift+x` | default |
| Browse scrollback in pager | `ctrl+shift+h` | default |
| Browse last command output | `ctrl+shift+g` | default |
| Search scrollback | `cmd+f`, `ctrl+shift+/` | default |

`cmd+up` and `cmd+down` are Kitty's default line-scroll keys. The window-focus overrides replace them, so use `opt+cmd+page_up` and `opt+cmd+page_down` to scroll by line.

## Clipboard

| Action | Shortcut | Source |
| ------ | -------- | ------ |
| Copy | `cmd+c`, `ctrl+shift+c` | default |
| Paste | `cmd+v`, `ctrl+shift+v` | default |
| Paste from selection | `ctrl+shift+s`, `shift+insert` | default |
| Pass selection to program | `ctrl+shift+o` | default |

## Font size

| Action | Shortcut | Source |
| ------ | -------- | ------ |
| Increase | `cmd+plus`, `cmd+=`, `shift+cmd+=`, `ctrl+shift+=`, `ctrl+shift+plus`, `ctrl+shift+kp_add` | default |
| Decrease | `cmd+minus`, `shift+cmd+minus`, `ctrl+shift+minus`, `ctrl+shift+kp_subtract` | default |
| Reset | `cmd+0`, `ctrl+shift+backspace` | default |

## Hints and URLs

| Action | Shortcut | Source |
| ------ | -------- | ------ |
| Open URL | `ctrl+shift+e` | default |
| Insert selected path | `ctrl+shift+p` then `f` | default |
| Open selected path | `ctrl+shift+p` then `shift+f` | default |
| Insert chosen file | `ctrl+shift+p` then `c` | default |
| Insert chosen directory | `ctrl+shift+p` then `d` | default |
| Insert selected line | `ctrl+shift+p` then `l` | default |
| Insert selected word | `ctrl+shift+p` then `w` | default |
| Insert selected hash | `ctrl+shift+p` then `h` | default |
| Open file at line number (`goto_file_line`) | `ctrl+shift+p` then `n` | default |
| Open selected hyperlink | `ctrl+shift+p` then `y` | default |

## Display

| Action | Shortcut | Source |
| ------ | -------- | ------ |
| Toggle fullscreen | `ctrl+cmd+f`, `ctrl+shift+f11` | default |
| Toggle maximized | `ctrl+shift+f10` | default |
| Cycle through OS windows | `` cmd+` `` | default |
| Cycle through OS windows backwards | `` cmd+shift+` `` | default |
| Increase background opacity | `ctrl+shift+a` then `m` | default |
| Decrease background opacity | `ctrl+shift+a` then `l` | default |
| Full background opacity | `ctrl+shift+a` then `1` | default |
| Reset background opacity | `ctrl+shift+a` then `d` | default |

## Clearing and resetting

| Action | Shortcut | Source |
| ------ | -------- | ------ |
| Clear terminal to cursor | `cmd+k` | default |
| Clear scrollback | `opt+cmd+k` | default |
| Clear last command | `cmd+l` | default |
| Clear screen and scroll | `ctrl+cmd+l` | default |
| Reset terminal | `opt+cmd+r`, `ctrl+shift+delete` | default |

## Config, help, and tools

| Action | Shortcut | Source |
| ------ | -------- | ------ |
| Show Kitty help | `ctrl+shift+f1` | default |
| Command palette | `ctrl+shift+f3` | default |
| Edit config file | `cmd+,`, `ctrl+shift+f2` | default |
| Reload config file | `ctrl+cmd+,`, `ctrl+shift+f5` | default |
| Debug config | `opt+cmd+,`, `ctrl+shift+f6` | default |
| Open Kitty shell | `ctrl+shift+escape` | default |
| Input unicode character | `ctrl+cmd+space`, `ctrl+shift+u` | default |
| Open Kitty website | `shift+cmd+/` | default |
| Send "Hello World" (demo binding) | `ctrl+shift+alt+h` | default |

## macOS application

| Action | Shortcut | Source |
| ------ | -------- | ------ |
| Hide Kitty | `cmd+h` | default |
| Hide other apps | `opt+cmd+h` | default |
| Minimize window | `cmd+m` | default |
| Toggle secure keyboard entry | `opt+cmd+s` | default |
| Quit | `cmd+q` | default |

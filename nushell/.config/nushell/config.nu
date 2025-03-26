# config.nu
#
# Installed by:
# version = "0.101.0"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# This file is loaded after env.nu and before login.nu
#
# You can open this file in your default editor using:
# config nu
#
# See `help config nu` for more options
#
# You can remove these comments if you want or leave
# them for future reference.

# ==================================================================
# ENVIROMENT
# ==================================================================
# load-env {
  
  # "EDITOR": "hx",
  # "MANPAGER": "sh -c 'col -bx | bat -l man -p'",
  # "PAGER": "less -imMWR",
  # "VISUAL_EDITOR": "zed",
  
  # "XDG_STATE_HOME": $"($env.HOME)/.local/state",
  # "XDG_DATA_HOME": $"($env.HOME)/.local/share",
  # "XDG_CACHE_HOME": $"($env.HOME)/.cache",
  # "XDG_CONFIG_HOME": $"($env.HOME)/.config",
  
  # "ICLOUD": $"($env.HOME)/Library/Mobile Documents/com~apple~CloudDocs/Documents",
  # "SRC": $"($env.HOME)/Source",
  # "GITHUB": $"($env.SRC)/github.com",
  # "GITCJ": $"($env.SRC)/gitlab.cj.dev",
  # "JEFF": $"($env.SRC)/github.com/jeffwindsor",
  # "DOTFILES": $"($env.JEFF)/dotfiles",
  # "NIXOS_CONFIG": $"($env.JEFF)/nixos-config",
  # "NIX_DARWIN_CONFIG": $"($env.JEFF)/nix-darwin-config"

# }

# ==================================================================
# CONFIG
# ==================================================================
# editor for nushell configs (config nu OR config env )
$env.config.buffer_editor = $env.EDITOR

# turn off default welcome banner
$env.config.show_banner = false

# path: Tue, Jan 1 01:34:56PM
$env.PROMPT_COMMAND_RIGHT = {date now | format date "%a, %b %d %I:%M:%S%p"}

# ==================================================================
# ALIASES
# ==================================================================


# STARSHIP PROMPT
mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")

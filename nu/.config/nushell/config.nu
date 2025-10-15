# config.nu
# version = "0.101.0"

# ═══════════════════════════════════════════════════
#  NUSHELL CONFIGURATION
# ═══════════════════════════════════════════════════
$env.config.show_banner = false
$env.config.buffer_editor = "nvim"
$env.config.table.mode = "none"
# $env.config.ls.use_ls_colors = true # use the LS_COLORS environment variable to colorize output
$env.config.ls.clickable_links = true # enable or disable clickable links. Your terminal has to support links.

# ═══════════════════════════════════════════════════
# == ENVIRONMENT ==
# ═══════════════════════════════════════════════════
$env.EDITOR          = "nvim"
$env.VISUAL          = "zed"
$env.MANPAGER        = "sh -c 'col -bx | bat -l man -p'"

#  xdg
$env.XDG_STATE_HOME  = ($env.HOME | path join ".local/state")
$env.XDG_DATA_HOME   = ($env.HOME | path join ".local/share")
$env.XDG_CACHE_HOME  = ($env.HOME | path join ".cache")
$env.XDG_CONFIG_HOME = ($env.HOME | path join ".config")

#  source control
$env.SOURCE          = ($env.HOME | path join "Source")
$env.SOURCE_GITHUB   = ($env.SOURCE | path join "github.com")
$env.SOURCE_GITCJ    = ($env.SOURCE | path join "gitlab.cj.dev")
$env.SOURCE_JEFF     = ($env.SOURCE | path join "github.com/jeffwindsor")
$env.DOTFILES = ($env.SOURCE_JEFF | path join "dotfiles")

#  Homebrew
$env.PATH = ($env.PATH | split row (char esep) | prepend '/opt/homebrew/bin')
$env.HOMEBREW_PREFIX = "/opt/homebrew"
$env.HOMEBREW_CELLAR = "/opt/homebrew/Cellar"
$env.HOMEBREW_REPOSITORY = "/opt/homebrew"
$env.HOMEBREW_NO_AUTO_UPDATE = "1"
$env.HOMEBREW_NO_INSTALL_CLEANUP = "1"

#  Autocompletion (ARGC)
let autocompletion_root = ($env.SOURCE_GITHUB | path join 'sigoden' 'argc-completions')
$env.ARGC_COMPLETIONS_ROOT = $autocompletion_root
$env.ARGC_COMPLETIONS_PATH = ($env.ARGC_COMPLETIONS_ROOT + '/completions/macos:' + $env.ARGC_COMPLETIONS_ROOT + '/completions')
$env.PATH = ($env.PATH
  | prepend ($env.ARGC_COMPLETIONS_ROOT)
  | prepend ($env.ARGC_COMPLETIONS_ROOT + '/bin'))

# MISE
$env.PATH = ($env.PATH | split row (char esep) | prepend '/Users/jefwinds/.local/bin')


# ═══════════════════════════════════════════════════
#  ALIASES
# ═══════════════════════════════════════════════════
alias p = run-external "pwd" "|" "pbcopy"

# muscle memory helpers
alias fg   = job unfreeze
alias jobs = job list
alias cat  = bat --plain
alias find = fd
alias grep = rg

# ═══════════════════════════════════════════════════
#  FUNCTIONS
# ═══════════════════════════════════════════════════
# Change Directory with clear and list all (used in autoload files)
def --env cdl [path, execute_ls=true] {
  cd $path
  clear
  if $execute_ls { ls -a; }
}

# Print Utils
def colorize [text, color] { $"(ansi $color)($text)(ansi reset)" }
def dimmed  [text] { show $text dark_gray }
def emphasize [text] { $"== ($text) ==" }
def fail    [text] { show $text red }
def header  [text] { show $"(emphasize $text)" cyan_reverse }
def info    [text] { show $text blue }
def normal  [text] { show $text reset }
def section [text] { show $"(emphasize $text)" cyan }
def show [text, color] { print (colorize $text $color) }
def success [text] { show $text green }
def warning [text] { show $text yellow }


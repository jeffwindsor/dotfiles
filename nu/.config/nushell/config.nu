# config.nu
# version = "0.101.0"

# == CONFIGURATION == 
$env.config.show_banner = false
$env.config.buffer_editor = "hx"
$env.config.table.mode = "none"
# $env.config.ls.use_ls_colors = true # use the LS_COLORS environment variable to colorize output
$env.config.ls.clickable_links = true # enable or disable clickable links. Your terminal has to support links.

# == ENVIRONMENT ==
$env.EDITOR          = "hx"
$env.VISUAL          = "zed"
$env.MANPAGER        = "sh -c 'col -bx | bat -l man -p'"

$env.XDG_STATE_HOME  = ($env.HOME | path join ".local/state")
$env.XDG_DATA_HOME   = ($env.HOME | path join ".local/share")
$env.XDG_CACHE_HOME  = ($env.HOME | path join ".cache")
$env.XDG_CONFIG_HOME = ($env.HOME | path join ".config")
$env.SOURCE          = ($env.HOME | path join "Source")
$env.SOURCE_GITHUB   = ($env.SOURCE | path join "github.com")
$env.SOURCE_GITCJ    = ($env.SOURCE | path join "gitlab.cj.dev")
$env.SOURCE_JEFF     = ($env.SOURCE | path join "github.com/jeffwindsor")

# == baskstop old muscle memory ==
alias fg   = job unfreeze
alias jobs = job list
alias cat  = bat --plain
alias find = fd
alias grep = rg

# Change Directory with clear and list all (used in autoload files)
def --env cdl [path, execute_ls=true] {
  cd $path
  clear
  if $execute_ls { ls -a; }
}

# == PRINT TO SCREEN ==
# Prints Reverse Cyan and adds bars
def header  [text] { show $"(emphasize $text)" cyan_reverse }
# Prints Cyan and adds bars
def section [text] { show $"(emphasize $text)" cyan }
# Prints blue
def info    [text] { show $text blue }
# Prints green
def success [text] { show $text green }
# Prints red
def fail    [text] { show $text red }
# Prints yellow
def warning [text] { show $text yellow }
# Prints dark gray
def dimmed  [text] { show $text dark_gray }
# Prints default color
def normal  [text] { show $text reset }
# Prints text in color
def show [text, color] { print (colorize $text $color) }
# Wraps text between "== " and " =="
def emphasize [text] { $"== ($text) ==" }
# Return ansi colored text
def colorize [text, color] { $"(ansi $color)($text)(ansi reset)" }

# auto complete framework
# https://github.com/sigoden/argc-completions
let autocompletion_root = ($env.HOME | path join '.local' 'share' 'argc-completions')
if not ($autocompletion_root | path exists) {
    print "Cloning Argc Completions to local share"
    git clone https://github.com/sigoden/argc-completions.git $autocompletion_root
    ($autocompletion_root)/scripts/download-tools.sh
    
}
$env.ARGC_COMPLETIONS_ROOT = $autocompletion_root
$env.ARGC_COMPLETIONS_PATH = ($env.ARGC_COMPLETIONS_ROOT + '/completions/macos:' + $env.ARGC_COMPLETIONS_ROOT + '/completions')
$env.PATH = ($env.PATH | prepend ($env.ARGC_COMPLETIONS_ROOT + '/bin'))
argc --argc-completions nushell | save -f ~/.config/nushell/vendor/autoload/argc-completions.nu

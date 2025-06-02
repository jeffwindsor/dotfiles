# config.nu
# version = "0.101.0"

$env.config.show_banner = false
$env.config.buffer_editor = "hx"
$env.config.table.mode = "none"
# $env.config.ls.use_ls_colors = true # use the LS_COLORS environment variable to colorize output
$env.config.ls.clickable_links = true # enable or disable clickable links. Your terminal has to support links.

$env.SOURCE        = ($env.HOME | path join "Source")
$env.SOURCE_GITHUB = ($env.SOURCE | path join "github.com")
$env.SOURCE_GITCJ  = ($env.SOURCE | path join "gitlab.cj.dev")
$env.SOURCE_JEFF   = ($env.SOURCE | path join "github.com/jeffwindsor")

# Clear and list all
def l [] {
  clear
  ls -a
}

# Change Directory with clear and list all
def --env cdl [path:string = "~/"] {
  cd $path
  clear
  ls -a
}

alias "....." = cd ../../../../
alias "...." = cd ../../../
alias "..." = cd ../../
alias ".." = cd ..
alias c = clear
alias cc = cdl $env.HOME
alias la = ls -a
alias ll = ls -l
alias lla = ls -la


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

def emphasize [text] { $"== ($text)" }
# return asni colored text
def colorize [text, color] { $"(ansi $color)($text)(ansi reset)" }

# Fuzzy Selection of list
def fuzzy-select [prompt, list] {
  $list
  | lines --skip-empty
  | input list --fuzzy (colorize (emphasize $prompt) blue)
}

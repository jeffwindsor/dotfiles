# config.nu
# version = "0.101.0"

$env.config.show_banner = false
$env.config.buffer_editor = "hx"
$env.config.table.mode = "none"
$env.config.ls.use_ls_colors = true # use the LS_COLORS environment variable to colorize output
$env.config.ls.clickable_links = true # enable or disable clickable links. Your terminal has to support links.

$env.SOURCE        = ($env.HOME | path join "Source")
$env.SOURCE_GITHUB = ($env.SOURCE | path join "github.com")
$env.SOURCE_GITCJ  = ($env.SOURCE | path join "gitlab.cj.dev")
$env.SOURCE_JEFF   = ($env.SOURCE | path join "github.com/jeffwindsor")

def edit [path] { hx $path }
def visual-edit [path] { zed $path }
def l [] {
  clear
  ls -a
}
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

# show / display helpers
def header  [text] { show $" == ($text) == " cyan_reverse }
def section [text] { show $"== ($text) ==" cyan }
def info    [text] { show $text blue }
def success [text] { show $text green }
def fail    [text] { show $text red }
def warning [text] { show $text yellow }
def dimmed  [text] { show $text dark_gray }
def normal  [text] { show $text reset }
def show    [text, color] { print $"(ansi $color)($text)(ansi reset)" }


# config.nu
# version = "0.101.0"

$env.config.show_banner = false
$env.config.buffer_editor = "hx"
$env.config.table.mode = "none"
$env.config.ls.use_ls_colors = true # use the LS_COLORS environment variable to colorize output
$env.config.ls.clickable_links = true # enable or disable clickable links. Your terminal has to support links.

# source folders
$env.SOURCE        = ($env.HOME | path join "Source")
$env.SOURCE_GITHUB = ($env.SOURCE | path join "github.com")
$env.SOURCE_GITCJ  = ($env.SOURCE | path join "gitlab.cj.dev")
$env.SOURCE_JEFF   = ($env.SOURCE | path join "github.com/jeffwindsor")

# functions - placed here so they can be used in autoloaded files
def edit [path] { hx $path }
def visual-edit [path] { zed $path }

# list and change directory
def l [] { clear; ls -a; }
def --env cdl [path:string = "~/"] { cd $path; l }

# show / display
def header  [text] { show $" == ($text) == " cyan_reverse }
def section [text] { show $"== ($text) ==" cyan }
def info    [text] { show $text blue }
def success [text] { show $text green }
def fail    [text] { show $text red }
def warning [text] { show $text yellow }
def dimmed  [text] { show $text dark_gray }
def normal  [text] { show $text reset }
def show    [text, color] { print $"(ansi $color)($text)(ansi reset)" }

# sync and upgrade everything
def up [] {
  dot-pull
  brew-up
  brew-sync 
  brew-clean
  dot-sync
  asdf-sync

  # reload application configs
  # run-external "ghostty" "+reload-config"  # not implemented yet
  run-external "aerospace" "reload-config"
}

# helix - have not moved to file yet
alias h = hx
alias "h." = hx .

# yazi
def --env y [...args] {
	let tmp = (mktemp -t "yazi-cwd.XXXXXX")
	yazi ...$args --cwd-file $tmp
	let cwd = (open $tmp)
	if $cwd != "" and $cwd != $env.PWD {
		cd $cwd
	}
	rm -fp $tmp
}

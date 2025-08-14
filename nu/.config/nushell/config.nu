# config.nu
# version = "0.101.0"

# == CONFIGURATION == 
$env.config.show_banner = false
$env.config.buffer_editor = "hx"
$env.config.table.mode = "none"
# $env.config.ls.use_ls_colors = true # use the LS_COLORS environment variable to colorize output
$env.config.ls.clickable_links = true # enable or disable clickable links. Your terminal has to support links.

# == ENVIRONMENT ==
$env.EDITOR = "hx"
$env.VISUAL = "zed"
$env.XDG_STATE_HOME = ($env.HOME | path join ".local/state")
$env.XDG_DATA_HOME = ($env.HOME | path join ".local/share")
$env.XDG_CACHE_HOME = ($env.HOME | path join ".cache")
$env.XDG_CONFIG_HOME = ($env.HOME | path join ".config")
$env.SOURCE        = ($env.HOME | path join "Source")
$env.SOURCE_GITHUB = ($env.SOURCE | path join "github.com")
$env.SOURCE_GITCJ  = ($env.SOURCE | path join "gitlab.cj.dev")
$env.SOURCE_JEFF   = ($env.SOURCE | path join "github.com/jeffwindsor")


# jump to config directory
alias config = cdl $env.XDG_CONFIG_HOME
# reroute to nushell version
alias cat = open
# emulate bash
alias fg = job unfreeze
alias jobs = job list


# == LISTINGS ==
# Clear and list all
def l [] {
  clear
  ls -a
}

# Change Directory with clear and list all
def --env cdl [path, execute_ls=true] {
  cd $path
  clear
  if $execute_ls { ls -a; }
}

alias "....." = cd ../../../../
alias "...." = cd ../../../
alias "..." = cd ../../
alias ".." = cd ..
alias c = clear
alias cc = cdl $env.HOME false
alias la = ls -a
alias ll = ls -l
alias lla = ls -la

# == QUERIES ==
# query current alias
def alias-query [query] {
  scope aliases
  | where {|r| $r.expansion =~ $query or $r.name =~ $query}
}
# alias ar = alias-query
alias aq = alias-query

# query current commands
def commands-query [query] {
  scope commands
  | where type == "custom"
  | where name like $query
}
alias cq = commands-query

# == PRINT / ECHO ==
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

# machine specific config
let	machine = networksetup -getcomputername
if ($machine == "WKMZTAFD6544") {
  echo "sqlplus"
  def sqlplus_run_file [connection: string, file: string] {
      rlwrap sqlplus $connection $"@($file)"
  }

  def shopcart [file: string] {
      sqlplus_run_file "jwindsor@shopcart.db.cj.com:1531/shopcart" $file
  }

  def t1 [file: string] {
      sqlplus_run_file "cj@tcjoweb1.db.cj.com:1521/tcjoweb1" $file
  }

  def t5 [file: string] {
      sqlplus_run_file "cj@tcjoweb5.db.cj.com:1521/tcjoweb5" $file
  }


  # CJ Claude Bedrock Experiment
  $env.CLAUDE_CODE_USE_BEDROCK = "1"
  $env.AWS_REGION = "us-west-2"
  $env.ANTHROPIC_MODEL = "us.anthropic.claude-sonnet-4-20250514-v1:0"
  $env.ANTHROPIC_SMALL_FAST_MODEL = "us.anthropic.claude-3-5-haiku-20241022-v1:0"
}

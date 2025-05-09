# config.nu
# version = "0.101.0"

# for hx to work in nushell: `sudo chown -R (whoami) /Users/(whoami)/.cache/`
$env.config.buffer_editor = "hx"
$env.config.show_banner = false
$env.config.table.mode = "restructured"

$env.XDG_STATE_HOME =  ($env.HOME | path join ".local/state")
$env.XDG_DATA_HOME =  ($env.HOME | path join ".local/share")
$env.XDG_CACHE_HOME =  ($env.HOME | path join ".cache")
$env.XDG_CONFIG_HOME =  ($env.HOME | path join ".config")
$env.HOMEBREW_PREFIX =  "/opt/homebrew"
$env.HOMEBREW_CELLAR =  "/opt/homebrew/Cellar"
$env.HOMEBREW_REPOSITORY =  "/opt/homebrew"
$env.HOMEBREW_NO_AUTO_UPDATE =  "1"
$env.HOMEBREW_NO_INSTALL_CLEANUP = "1"
$env.SOURCE = ($env.HOME | path join "Source")
$env.SOURCE_GITHUB = ($env.SOURCE | path join "github.com")
$env.SOURCE_GITCJ = ($env.SOURCE | path join "gitlab.cj.dev")
$env.SOURCE_JEFF = ($env.SOURCE | path join "github.com/jeffwindsor")
$env.DOTFILES = ($env.SOURCE_JEFF | path join "dotfiles")
$env.PATH = ($env.PATH | split row (char esep) | prepend '/opt/homebrew/bin')

# includes (non-modules)
source show.nu
source navigation.nu 
source git.nu
source sync.nu
source starship.nu

# completions from nushell's github
source git-completions.nu
source rg-completions.nu
source man-completions.nu


# dotfiles
alias d = cdl $env.DOTFILES
alias de = edit $env.DOTFILES
alias dv = visual-edit $env.DOTFILES
alias ds = config nu
alias dg = lazygit --path $env.DOTFILES 

# muscle memory coverage, reduce over time
alias cat = open
def ar [query] {scope aliases | where {|r| $r.expansion =~ $query or $r.name =~ $query} }
def af [query] {
  help commands
  | where command_type == "custom"
  | where name =~ $query
  | select name params 
}

# research these:
# AWESOME: https://github.com/nushell/awesome-nu?tab=readme-ov-file#plugins
# 
#   Plugins
#   https://github.com/cptpiepmatz/nu-plugin-highlight
#
#   Scripts
#   https://github.com/fj0r/ai.nu
#
#   Completions
#   https://github.com/nushell/nu_scripts/tree/main/custom-completions
#
#   Integrations
#   https://github.com/selfagency/bru
#   https://github.com/carapace-sh/carapace-bin
#   https://github.com/direnv/direnv/blob/master/docs/hook.md#nushell
#   https://github.com/hustcer/deepseek-review
#   https://github.com/kellyjonbrazil/jc


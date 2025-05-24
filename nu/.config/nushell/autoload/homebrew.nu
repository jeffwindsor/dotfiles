$env.PATH = ($env.PATH | split row (char esep) | prepend '/opt/homebrew/bin')
$env.HOMEBREW_PREFIX = "/opt/homebrew"
$env.HOMEBREW_CELLAR = "/opt/homebrew/Cellar"
$env.HOMEBREW_REPOSITORY = "/opt/homebrew"
$env.HOMEBREW_NO_AUTO_UPDATE = "1"
$env.HOMEBREW_NO_INSTALL_CLEANUP = "1"

alias bn = brew install
alias bi = brew info
alias bs = brew search

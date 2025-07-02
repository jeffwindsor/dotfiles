# List all available plugins: asdf plugin-list-all
# Install a plugin: asdf plugin-add {{name}}
# List all available versions for a package: asdf list-all {{name}}
# Install a specific version of a package: asdf install {{name}} {{version}}
# Set global version for a package: asdf global {{name}} {{version}}
# Set local version for a package: asdf local {{name}} {{version}}

# Fuzzy Selection of list
def fuzzy-select [prompt, list] {
  let prompt = (colorize (emphasize $prompt) blue)
  $list | input list --fuzzy $prompt
}

# ASDF installed plugins with current version
def asdf-list-current [] {
  # detect columns was used since command output has a header row and multiple columns
  # example output:
  # Name            Version         Source                            Installed
  # nodejs          23.0.0          /Users/jeffwindsor/.tool-versions true
  asdf current
  | detect columns
}

# ASDF Plugins 
def asdf-list-plugins-all [] {
  # parse with column names was used since command output has two columns but no header row
  # example output:
  # java                           https://github.com/halcyon/asdf-java.git
  # jb                             https://github.com/beardix/asdf-jb.git
  asdf plugin list all
  | parse "{package} {url}"
  | get package
}
def asdf-list-plugins-installed [] {
  # lines used to split stream into strings
  asdf plugin list
  | lines
}

# ASDF Versions for a Plugin
def asdf-list-plugin-versions-all [plugin] {
  # lines used to split stream into strings
  asdf list all $plugin
  | lines
}
def asdf-list-plugin-versions-installed [plugin] {
  # lines used to split stream into strings
  asdf list $plugin
  | lines
}

# ASDF add available Plugin, optionally add a version as current
def asdf-install-plugin [add_with_a_version: bool = true] {
  let plugin = fuzzy-select "Select Plugin to Install" (asdf-list-plugins-all) 
  if (($plugin | is-not-empty) and $add_with_a_version) {
    asdf plugin add $plugin
    asdf-install-plugin-version $plugin
  }
}

# ASDF Add available Version for Plugin, optionally set version as current
def asdf-install-plugin-version [plugin, set_as_current: bool = true] {
  let version = fuzzy-select $"Select ($plugin) Version to Install"  (asdf-list-plugin-versions-all $plugin)
  if ($version | is-not-empty) {
    asdf install $plugin $version 
    if $set_as_current { asdf set $plugin $version }
  }
}

# ASDF: Select Plugin Version and set as current
def asdf-set-plugin-version [] {
  let plugin = fuzzy-select "Select Plugin" (asdf-list-plugins-installed)
  if ($plugin | is-not-empty) {
    let version = fuzzy-select $"Select ($plugin) Version"  (asdf-list-versions-installed $plugin)
    if ($version | is-not-empty) {
      # currently selected version begins with *
      asdf set $plugin ($version | str replace "*" "")
    }
  }
}


alias anp = asdf-install-plugin
alias anpv = asdf-install-plugin-version 
alias aspv = asdf-set-plugin-version

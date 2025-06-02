# List all available plugins: asdf plugin-list-all
# Install a plugin: asdf plugin-add {{name}}
# List all available versions for a package: asdf list-all {{name}}
# Install a specific version of a package: asdf install {{name}} {{version}}
# Set global version for a package: asdf global {{name}} {{version}}
# Set local version for a package: asdf local {{name}} {{version}}

alias anp = asdf-install-plugin
alias anv = asdf-install-version 
alias asv = asdf-set-current-version
alias asdf-list-plugins-all = fuzzy-select "Select ASDF Available Plugin" (asdf plugin list all | parse "{package} {url}" | get package)
alias asdf-list-plugins-installed = fuzzy-select "Select ASDF Plugin" (asdf plugin list)
def asdf-list-versions-all [plugin] { fuzzy-select $"Select ($plugin) Available Version" (asdf list all $plugin) }
def asdf-list-versions-installed [plugin] {fuzzy-select $"Select ($plugin) Version" (asdf list $plugin) }



# ASDF: Current Plugin Version
export def asdf-current [] { asdf current | detect columns }


# ASDF: Add available Plugin, optionally add Version
export def asdf-install-plugin [add_version: bool = true] {
  let plugin = asdf-list-plugins-all 
  if (($plugin | is-not-empty) and $add_version) {
    asdf plugin add $plugin
    asdf-install-plugin-version $plugin
  }
}

# ASDF: Add Version to Plugin
export def asdf-install-version [] {
  let plugin = asdf-list-plugins-installed
  if ($plugin | is-not-empty) {
    asdf-install-plugin-version $plugin
  }
}

# ASDF: Add available Version for Plugin, optionally set version as current
def asdf-install-plugin-version [plugin, set_as_current: bool = true] {
  let version = asdf-list-versions-all $plugin
  if ($version | is-not-empty) {
    asdf install $plugin $version 
    if $set_as_current { asdf set $plugin $version }
  }
}

# ASDF: Select Plugin Version and set as current
export def asdf-set-current-version [] {
  let plugin = asdf-list-plugins-installed
  if ($plugin | is-not-empty) {
    let version = asdf-list-versions-installed $plugin
    if ($version | is-not-empty) {
      # currently selected version begins with *
      asdf set $plugin ($version | str replace "*" "")
    }
  }
}



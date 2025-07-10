
def mise-install [] {
  let plugin = mise plugins ls-remote
              | tv --input-header "Select Plugin"
  
  if ($plugin | is-not-empty) {
    let version = mise ls-remote $plugin
                  | append "latest"      # useful, but not given by mise output
                  | lines
                  | sort --reverse
                  | to text
                  | tv --input-header $"Select ($plugin) Version"
    if ($version | is-not-empty) {
      mise plugins install $"($plugin)@($version)"
    }
  }
}

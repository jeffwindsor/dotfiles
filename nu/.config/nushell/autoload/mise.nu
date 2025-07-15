def mise-install-version [plugin] {
  # if input or selection available, pick version
  if ($plugin | is-not-empty) {
    # print $"Select ($plugin) Version"
    let version = mise ls-remote $plugin
                  | append "latest"      # useful, but not given by mise output
                  | lines
                  | sort --reverse -n
                  | to text
                  | tv --input-header $"Select ($plugin) Version"        


    if ($version | is-not-empty) {
      mise install $"($plugin)@($version)" 
    }

  } else {
    # print $"No ($plugin) version Selected"
  }
}


def mise-install [plugin=""] {
  if ($plugin | is-empty) {
    # no plugin given, ask to select from full list of plugins
    # print "No Plugin Given, Selection Required"
    # I only want asdf sourced options, filter duplicates
    let asdfs = mise registry --backend asdf --hide-aliased | lines
    let cores = mise registry --backend core --hide-aliased | lines
    let plugin = $asdfs | append $cores 
                | to text
                | tv --input-header "Select Plugin" --source-display="{split: :0}" --source-output="{split: :-1}"
    # print $"Plugin Selected: ($plugin)"
    mise-install-version $plugin
    
  } else {
    # print $"Plugin Given ($plugin)"
    mise-install-version $plugin
    
  }

}

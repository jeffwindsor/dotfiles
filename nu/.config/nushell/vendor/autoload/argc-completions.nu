
if not ($autocompletion_root | path exists) {
    print "Cloning Argc Completions to local share"
    git clone git@github.com:sigoden/argc-completions.git $autocompletion_root
    ($autocompletion_root)/scripts/download-tools.sh
}
#argc --argc-completions nushell | save -f ~/.config/nushell/vendor/autoload/argc-completions.nu

def arg-gen [command] {
  run-external ($env.ARGC_COMPLETIONS_ROOT + '/Argcfile.sh') 'generate' $command 
}

def _argc_completer [args: list<string>] {
    argc --argc-compgen nushell "" ...$args
        | split row "\n"
        | each { |line| $line | split column "\t" value description }
        | flatten 
}

let external_completer = {|spans| 
    _argc_completer $spans
}

$env.config.completions.external.enable = true
$env.config.completions.external.completer = $external_completer

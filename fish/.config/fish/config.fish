if status is-interactive
    # Commands to run in interactive sessions can go here

    export XDG_STATE_HOME=$HOME/.local/state
    export XDG_DATA_HOME=$HOME/.local/share
    export XDG_CACHE_HOME=$HOME/.cache
    export XDG_CONFIG_HOME=$HOME/.config

    for file in $XDG_CONFIG_HOME/env/* ; do source $file ; done

    for file in $ZDOTDIR/autoloads/* ; do source $file ; done

    for file in $XDG_CONFIG_HOME/aliases/* ; do source $file ; done

end

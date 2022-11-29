if status is-interactive
    # Commands to run in interactive sessions can go here

    export XDG_STATE_HOME=$HOME/.local/state
    export XDG_DATA_HOME=$HOME/.local/share
    export XDG_CACHE_HOME=$HOME/.cache
    export XDG_CONFIG_HOME=$HOME/.config

    for file in $XDG_CONFIG_HOME/env/*
        source $file
    end

    for file in $XDG_CONFIG_HOME/fish/autoloads/*
        source $file
    end

    for file in $XDG_CONFIG_HOME/aliases/*
        source $file
    end

end

function fish_greeting
    set_color blue
    fortune $XDG_DATA_HOME/fortune/
    set_color normal
end

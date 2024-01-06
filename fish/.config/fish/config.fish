if status is-interactive
    # Commands to run in interactive sessions can go here
    set fish_greeting
    starship init fish | source
    export PYENV_ROOT="$HOME/.pyenv"
    command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
    export VOLTA_HOME="$HOME/.volta"
    export PATH="$VOLTA_HOME/bin:$PATH"
    #direnv hook fish | source
end

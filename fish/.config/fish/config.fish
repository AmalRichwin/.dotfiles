if status is-interactive
    # Commands to run in interactive sessions can go here
    set fish_greeting
    starship init fish | source
    export PYENV_ROOT="$HOME/.pyenv"
    command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
    #direnv hook fish | source
end

set _CONDA_ROOT "/home/richwin/miniconda3"
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /home/richwin/miniconda3/bin/conda
    eval /home/richwin/miniconda3/bin/conda "shell.fish" "hook" $argv | source
end
# <<< conda initialize <<<

zoxide init fish | source

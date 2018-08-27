unsetopt bg_nice

export HISTFILE=/dev/null
export KEYTIMEOUT=1
export PATH=~/.local/bin:"$PATH"
export VISUAL=vim

export PYENV_ROOT=~/.local/share/pyenv
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

if [[ $(command -v ag) ]]; then
    export FZF_DEFAULT_COMMAND="ag --hidden --ignore .git -l"
fi

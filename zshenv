unsetopt bg_nice

export KEYTIMEOUT=1
export PATH=~/.local/bin:"$PATH"
export PYTHONSTARTUP=~/.config/pythonrc

export PYENV_ROOT=~/.local/share/pyenv
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

if [[ $(command -v vim) ]]; then
    export VISUAL=vim
fi

if [[ $(command -v ag) ]]; then
    export FZF_DEFAULT_COMMAND="ag --hidden --ignore .git -l"
fi

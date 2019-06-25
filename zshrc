autoload -U is-at-least

setopt extendedglob globdots histignorespace nobgnice
umask 022

stty -ixon
bindkey -e
bindkey "\e[1~" beginning-of-line
bindkey "\e[4~" end-of-line
bindkey -s "^S" "^Asudo ^E"

PURE_CMD_MAX_EXEC_TIME=1
source ~/.config/zsh_plugins.sh

unalias ag 2>/dev/null
alias -g ...=../..
alias -g ....=../../..
alias gdb="gdb -q"
alias latexmk="latexmk -pdf -interaction=nonstopmode -halt-on-error"
alias pk="pkill -9 -t"

if [[ -n $(command -v bat) ]]; then
    alias cat=bat
    alias preview="fzf --preview='bat --color always {}'"
else
    alias preview="fzf --preview='cat {}'"
fi

if [[ -n $(command -v exa) ]]; then
    alias l="LANG=C.UTF-8 exa --time-style=long-iso -l"
    alias la="l -a"
    alias lt="l -smod"
    alias lat="l -asmod"
else
    alias l="LANG=C.UTF-8 ls  --time-style=long-iso -lh --color"
    alias la="l -A"
    alias lt="l -tr"
    alias lat="l -Atr"
fi
alias ll=l
alias lr="l -R"
alias lar="la -R"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export KEYTIMEOUT=1
export PYTHONSTARTUP=~/.config/pythonrc

if [[ -n $(command -v rg) ]]; then
    export FZF_DEFAULT_COMMAND="rg --files --hidden -g '!.git'"
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

if [[ -n $(command -v thefuck) ]]; then
    eval $(thefuck --alias f)
fi

if [[ -n $(command -v vim) ]]; then
    export VISUAL=vim
fi

# Should be at last
if [[ -n $(command -v tmux) && -z $TMUX ]]; then
    cd
    tmux -2 new -As 0
fi

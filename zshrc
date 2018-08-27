autoload -U is-at-least

setopt extendedglob globdots
stty start undef
stty stop  undef
bindkey -e
bindkey "\e[1~" beginning-of-line
bindkey "\e[4~" end-of-line

PURE_CMD_MAX_EXEC_TIME=1
source ~/.config/zsh_plugins.sh
bindkey "\e[A" history-substring-search-up
bindkey "\e[B" history-substring-search-down

unalias ag 2>/dev/null
alias -g ...=../..
alias -g ....=../../..

if [[ $(command -v exa) ]]; then
    alias l="LANG=C.UTF-8 exa --git  --time-style=long-iso -l"
    alias la="l -a"
    alias lt="l -smod"
    alias lat="l -asmod"
else
    alias l="LANG=C.UTF-8 ls --color --time-style=long-iso -lh"
    alias la="l -A"
    alias lt="l -tr"
    alias lat="l -Atr"
fi
alias ll=l
alias lr="l -R"
alias lar="la -R"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Should be at last
if [[ $(command -v tmux) && ! $TMUX ]]; then
    TERM=putty-256color tmux -2 new -As 0
fi

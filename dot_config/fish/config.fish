set -gx LESSHISTFILE -

fish_add_path -Pm ~/.local/bin

if type -q bat
    set -gx BAT_PAGER 'less -FR --mouse'
    # set -gx BAT_THEME base16
end

if type -q tmux
    fish_add_path -Pm ~/.tmux/plugins/tmux-mem-cpu-load
end

fish_add_path -Pm ~/.cargo/bin

# Plugins come from .chezmoiexternal.toml. They are laid out for fisher but
# loaded here, as fisher keeps its state in fish_variables (.chezmoiremove).
set -l data_home ~/.local/share
set -q XDG_DATA_HOME; and set data_home $XDG_DATA_HOME
if not test -e $data_home/z/data; and test -f ~/.z
    command mkdir -m 700 -p $data_home/z
    command cp ~/.z $data_home/z/data
end
for plugin in $data_home/fish/plugins/*
    set -l fisher_path $plugin
    set fish_function_path $fish_function_path[1] $plugin/functions $fish_function_path[2..-1]
    set fish_complete_path $fish_complete_path[1] $plugin/completions $fish_complete_path[2..-1]
    for file in $plugin/conf.d/*.fish
        source $file
    end
end

if status is-interactive
    test -t 0; and stty -ixon
    umask 077
    set -g fish_greeting

    if not set -q TMUX; and type -q tmux
        set -l ppid (ps -o ppid= -p $fish_pid | string trim)
        set -l pppid (ps -o ppid= -p $ppid | string trim)
        if not string match -q nautilus (cat /proc/$pppid/comm 2>/dev/null)
            # exit only stops sourcing this file, so leave at the first prompt.
            if tmux new -As main
                function __tmux_exit --on-event fish_prompt
                    exit
                end
                exit
            end
        end
    end

    set -g fish_escape_delay_ms 10
    set -g fish_color_error red
    set -g fish_color_valid_path cyan

    set -gx LESS -FKR --mouse
    set -gx TIME_STYLE long-iso
    set -gx VIRTUAL_ENV_DISABLE_PROMPT 1
    # tide draws the prompt in a child fish, which cannot see fish_key_bindings
    # once fish 4.3 made it global (IlanCosman/tide#620).
    set -q fish_key_bindings; or set -g fish_key_bindings fish_default_key_bindings
    set -gx fish_key_bindings $fish_key_bindings
    set -gx FZF_DEFAULT_OPTS '--bind=ctrl-a:select-all,ctrl-d:deselect-all --height=40%'
    # set -gx FZF_DEFAULT_OPTS --height=~90%

    alias gdb 'gdb -q'
    alias latexmk 'latexmk -pdf -halt-on-error -interaction=nonstopmode'
    alias mkdir 'mkdir -p'
    alias pk 'pkill -9 -t'
    alias rm 'rm -I'
    alias t 'tail -f'

    if type -q bat
        alias cat bat
        alias preview 'fzf --preview="bat --color always {}"'
    else
        alias preview 'fzf --preview="cat {}"'
    end

    if type -q eza
        function l --wraps eza
            LANG=C.UTF-8 eza -lg --group-directories-first $argv
        end
        alias la 'l -a'
        alias lr 'l -T'
        alias lt 'l -smod'
        alias lw 'l -G'
        alias lar 'la -T'
        alias lat 'la -smod'
    else
        function l --wraps ls
            LANG=C.UTF-8 ls -hl --color $argv
        end
        alias la 'l -A'
        alias lr 'l -R'
        alias lt 'l -tr'
        alias lar 'la -R'
        alias lat 'la -tr'
    end

    if type -q fd
        set -gx FZF_DEFAULT_COMMAND 'fd -HE.git --strip-cwd-prefix -tf'
        set -gx FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
    end

    if type -q gvim
        alias vim 'gvim -v'
        set -gx VISUAL gvim -v
    else if type -q vim
        set -gx VISUAL vim
    end
    if set -q VISUAL
        alias vi vim
        set -gx EDITOR $VISUAL
    end

    if test -d ~/.vim/plugged/fzf/bin
        fish_add_path -Pa ~/.vim/plugged/fzf/bin
    end
    # fzf's fish integration requires fish 3.4 or newer.
    if type -q fzf; and not string match -qr '^3\.[0-3]\.' $FISH_VERSION
        fzf --fish 2>/dev/null | source
    end

    if test -r ~/.local/share/lscolors.sh
        set -gx LS_COLORS (string replace -rf "^LS_COLORS='(.*)';\$" '$1' <~/.local/share/lscolors.sh)
    else if type -q dircolors
        set -gx LS_COLORS (dircolors -b | string replace -rf "^LS_COLORS='(.*)';\$" '$1')
    end
end

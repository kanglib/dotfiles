set -gx FZF_DEFAULT_COMMAND fd -H -tf --strip-cwd-prefix

if status is-interactive
    # set -gx BAT_THEME base16
    # set -gx FZF_DEFAULT_OPTS --height=~90%
    set -gx LESS -FKR --mouse
    set -gx LESSHISTFILE -

    if type -q gvim
        set -gx VISUAL gvim -v
    else
        set -gx VISUAL vim
    end
    set -gx EDITOR $VISUAL

    fish_add_path ~/.tmux/plugins/tmux-mem-cpu-load
end

fish_add_path ~/.cargo/bin
fish_add_path ~/.local/bin

function fish_user_key_bindings
    bind \e\[1~ beginning-of-line
    bind \e\[4~ end-of-line
    bind \e\[5~ beginning-of-history
    bind \e\[6~ end-of-history

    # zsh global aliases ...=../.. and so on: typing a dot after .. inserts /..
    bind . __rationalise_dot
    bind \cz __fancy_ctrl_z
end

function __rationalise_dot
    if string match -qr '(^|/)\.\.$' -- (commandline -ct)
        commandline -i /..
    else
        commandline -i .
    end
end

# oh-my-zsh fancy-ctrl-z: Ctrl-Z on an empty line runs fg
function __fancy_ctrl_z
    if test -z (commandline | string collect)
        commandline -r fg
        commandline -f execute
    end
end

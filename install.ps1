# PowerShell 5.0+

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
md -f ~\.config >$null
setx HOME "$env:USERPROFILE"

function inst ($src, $dest) {
    if (Test-Path $dest) {
        if (gi -ea SilentlyContinue $dest | ?{$_.LinkType}) {
            (gi $dest).Delete() >$null
        } else {
            mv -Force $dest "$dest.bak" >$null
        }
    }
    ni -it SymbolicLink $dest -Value $src >$null
}

inst git ~\.config\git
ni -ea SilentlyContinue ~\.config\gitconfig.local >$null

inst pythonrc ~\.config\pythonrc
md -f ~\pip >$null
inst pip\pip.conf ~\pip\pip.ini
setx PYTHONSTARTUP $env:HOME\.config\pythonrc

if (gcm -ea SilentlyContinue gvim) {
    inst vimrc ~\.vimrc
    md -f ~\.vim\autoload >$null
    inst ycm_extra_conf.py ~\.vim\.ycm_extra_conf.py
    curl git.io/VgrSsw -OutFile ~\.vim\autoload\plug.vim
    gvim +PlugClean! +PlugUpdate +qa

    # Why bother i386? 😂
    $pattern = [regex]"https://[\w./-]+windows_amd64\.zip"
    $json = curl https://api.github.com/repos/junegunn/fzf-bin/releases/latest
    $temp = "$env:TEMP\fzf.zip"
    curl $pattern.Match($json).Value -OutFile $temp
    Expand-Archive -f -Path $temp -DestinationPath ~\.local\share\fzf\bin

    if (gcm -ea SilentlyContinue rg) {
        setx FZF_DEFAULT_COMMAND "rg --files --hidden -g '!.git'"
    }
}

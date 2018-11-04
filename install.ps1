# PowerShell 5.0+

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
setx HOME "$env:USERPROFILE"
md -Force ~\.config >$null

function inst ($src, $dest) {
    if (Test-Path $dest) {
        mv -Force $dest "$dest.bak" >$null
    }
    ni -ItemType SymbolicLink $dest -Value $src >$null
}

inst gitconfig ~\.gitconfig
inst gitignore ~\.config\gitignore
ni -Force ~\.config\gitconfig.local >$null

inst pythonrc ~\.config\pythonrc
setx PYTHONSTARTUP $env:HOME\.config\pythonrc
md -Force ~\pip >$null
inst pip.conf ~\pip\pip.ini

if (gcm -ErrorAction SilentlyContinue gvim) {
    md -Force ~\.vim\autoload >$null
    curl git.io/VgrSsw -OutFile ~\.vim\autoload\plug.vim
    inst vimrc ~\.vimrc
    inst ycm_extra_conf.py ~\.config\ycm_extra_conf.py
    gvim +PlugClean! +PlugUpdate +qa

    # Why bother i386? 😂
    $pattern = [regex]"https://[\w./-]+windows_amd64\.zip"
    $json = curl https://api.github.com/repos/junegunn/fzf-bin/releases/latest
    $temp = "$env:TEMP\fzf.zip"
    curl $pattern.Match($json).Value -OutFile $temp
    Expand-Archive -Force -Path $temp -DestinationPath ~\.local\share\fzf\bin

    if (gcm -ErrorAction SilentlyContinue ag) {
        setx FZF_DEFAULT_COMMAND "ag --hidden --ignore .git -l"
    }
}

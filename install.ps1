# PowerShell 5.0+

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
mkdir -f ~\.config > $null
setx HOME "$env:USERPROFILE"

function inst ($src,$dest) {
    if (Test-Path $dest) {
        if (Get-Item -ea SilentlyContinue $dest | Where-Object { $_.LinkType }) {
            (Get-Item $dest).Delete() > $null
        } else {
            mv -Force $dest "$dest.bak" > $null
        }
    }
    New-Item -it SymbolicLink $dest -Value $src > $null
}

inst git ~\.config\git
New-Item -ea SilentlyContinue ~\.config\gitconfig.local > $null

inst pythonrc ~\.config\pythonrc
mkdir -f ~\pip > $null
inst pip\pip.conf ~\pip\pip.ini
setx PYTHONSTARTUP $env:HOME\.config\pythonrc

if (Get-Command -ea SilentlyContinue gvim) {
    inst vimrc ~\.vimrc
    mkdir -f ~\.vim\autoload > $null
    curl git.io/VgrSsw -OutFile ~\.vim\autoload\plug.vim
    gvim +PlugClean! +PlugUpdate +qa

    # Why bother i386? 😂
    $pattern = [regex]"https://[\w./-]+windows_amd64\.zip"
    $json = curl https://api.github.com/repos/junegunn/fzf-bin/releases/latest
    $temp = "$env:TEMP\fzf.zip"
    curl $pattern.Match($json).Value -OutFile $temp
    Expand-Archive -f -Path $temp -DestinationPath ~\.local\share\fzf\bin

    if (Get-Command -ea SilentlyContinue rg) {
        setx FZF_DEFAULT_COMMAND 'rg --files --hidden -g "!.git"'
    }
}

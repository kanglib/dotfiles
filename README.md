# dotfiles

[@kanglib](https://github.com/kanglib) does dotfiles

## Supported systems

- Arch/Fedora/Ubuntu x86-64 (WSL supported)
- Windows Terminal and Alacritty
- GVim ([vim-tux](https://tuxproject.de/projects/vim) or
  [vim-win32-installer](https://github.com/vim/vim-win32-installer/releases))
  on Windows 10+

## Requirements

- Vim 8.1+
  - Python 3 support
  - Lua/clipboard support (recommended)
- Tomorrow Night theme
  ([base16 version](https://github.com/chriskempson/base16-templates-source))
- [D2Coding 1.3+](https://github.com/naver/d2codingfont/releases/latest)
  (recommended)
- `PATH` set correctly

## Installation

```sh
# Arch
sudo pacman -S cmake git gvim tmux zsh lsb-release
sudo pacman -S ctags gdb
sudo pacman -S bat eza fd git-delta ripgrep
sudo pacman -S python-virtualenvwrapper

# Fedora
sudo dnf install cmake git lua vim-X11 vim-enhanced tmux zsh redhat-lsb-core gcc-c++ sqlite
sudo dnf install ctags gdb
sudo dnf install bat eza fd-find git-delta ripgrep
sudo dnf install python3-virtualenvwrapper

# Ubuntu 18.04
sudo add-apt-repository ppa:jonathonf/vim
sudo apt install cmake git vim vim-gtk3 tmux zsh
sudo apt install ctags gdb
...
cargo install bat eza fd-find git-delta ripgrep
pip install virtualenvwrapper

# Pick one
sh -c "$(curl -fsLS get.chezmoi.io/lb)" -- init --apply kanglib
sh -c "$(curl -fsLS chezmoi.io/getlb)" -- init --apply kanglib

# 🚀
chsh -s /bin/zsh
exec zsh
```

## pythonrc

Python prompts are colorized on POSIX systems.

## vimrc

### Language Server Protocol

The LSP is supported via [vim-lsp](https://github.com/prabirshrestha/vim-lsp).
<kbd>F7</kbd> can be used to install/update the suggested language server.

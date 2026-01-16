# dotfiles

[@kanglib](https://github.com/kanglib) does dotfiles

## Supported systems

- Arch/Red Hat/Ubuntu x86-64 (WSL supported)
- Windows Terminal/Alacritty
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
sudo pacman -S bat eza fd git gvim ripgrep tmux zsh
sudo pacman -S cmake python-virtualenvwrapper git-delta
sudo pacman -S inetutils lsb-release lua perl-term-readkey
sudo pacman -S ctags

# Red Hat
sudo dnf install bat eza fd-find git vim-X11 ripgrep tmux zsh
sudo dnf install cmake python3-virtualenvwrapper git-delta vim-enhanced
sudo dnf install gcc-c++ lua redhat-lsb-core sqlite
sudo dnf install ctags

# Ubuntu 22.04
sudo apt install bat exa fd-find git vim-gtk3 ripgrep tmux zsh
sudo apt install cmake virtualenvwrapper vim
sudo apt install ctags
ln -s $(which batcat) ~/.local/bin/bat
ln -s $(which exa) ~/.local/bin/eza
ln -s $(which fdfind) ~/.local/bin/fd
...
cargo install git-delta

# Pick one
sh -c "$(curl -fsLS get.chezmoi.io/lb)" -- init --apply kanglib
sh -c "$(curl -fsLS chezmoi.io/getlb)" -- init --apply kanglib

# 🚀
chsh -s /bin/zsh
exec zsh
```

## vimrc

### Language Server Protocol

The LSP is supported via [vim-lsp](https://github.com/prabirshrestha/vim-lsp).
<kbd>F7</kbd> can be used to install/update the suggested language server.

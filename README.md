# dotfiles
[@kanglib](https://github.com/kanglib) does dotfiles

## Supported systems
* Ubuntu 14.04+ via Windows Terminal/PuTTY/WSL
* Windows 10 x64 with
    [GVim](https://github.com/vim/vim-win32-installer/releases)

## Requirements
* Vim 8
* Tomorrow Night theme
    ([base16 version](https://github.com/chriskempson/base16#scheme-repositories))
* Clang ([Windows](http://releases.llvm.org/download.html))
* [Exuberant Ctags](http://ctags.sourceforge.net/)
* [Python](https://www.python.org/downloads/) (3.6+ recommended)
* [D2Coding](https://github.com/naver/d2codingfont/releases/latest) 1.3+
    (recommended)
* `PATH` variable is set correctly

## Installation

    sudo apt install gdb tmux zsh unzip vim exuberant-ctags python3-venv
    ./install
    # (Re)start Zsh

## gitconfig
Install [delta](https://github.com/dandavison/delta/releases/latest) to make
`git diff` pretty. (Unix only)

## pythonrc
Python prompts are colorized on POSIX systems.

## vimrc
### Clang on Windows
I use Clang as the default C/C++ compiler. Modify the <kbd>F5</kbd> bindings if
you want MSVC/GCC or another.

### Language Server Protocol
The LSP is supported via [vim-lsp](https://github.com/prabirshrestha/vim-lsp).
<kbd>F7</kbd> can be used to install or update the suggested language server.

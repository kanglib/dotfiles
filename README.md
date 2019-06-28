# dotfiles
[@kanglib](https://github.com/kanglib) does dotfiles

## Supported systems
* Ubuntu 14.04+ via PuTTY (WSL is OK)
* Windows 10 x64 with
    [GVim](https://github.com/vim/vim-win32-installer/releases)

## Requirements
* Vim 8
* Tomorrow Night theme
    ([base16 version](https://github.com/chriskempson/base16#scheme-repositories))
* Clang ([Windows](http://releases.llvm.org/download.html))
* [Exuberant Ctags](http://ctags.sourceforge.net/)
* [Python](https://www.python.org/downloads/) (3.6 recommended)
* [D2Coding](https://github.com/naver/d2codingfont/releases/latest) 1.3+
    (recommended)
* `PATH` variable is set correctly

## Installation

    sudo apt install gdb tmux zsh unzip vim exuberant-ctags
    # Install Jedi for versions you want
    sudo pip2 install jedi
    sudo pip3 install jedi pynvim
    ./install
    # (Re)start Zsh

## pythonrc
Python prompts are colorized on POSIX systems.

## vimrc
### Clang on Windows
I use Clang as the default C/C++ compiler. Modify the F5 key bindings if you
want MSVC/GCC or another.

### [NCM2](https://github.com/ncm2/ncm2)
On Windows with both Python 2/3, copy or link the 3's executable to
`python3.exe`; otherwise nvim-yarp will refuse to work.

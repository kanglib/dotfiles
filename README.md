# dotfiles
[@kanglib](https://github.com/kanglib) does dotfiles

## Supported systems
* Ubuntu 14.04+ via PuTTY (WSL is OK)
* Windows 10 x64 with [GVim](https://bintray.com/micbou/generic/vim)

## Requirements
* Vim 8
* Tomorrow Night theme [base16 version](https://github.com/chriskempson/base16#scheme-repositories)
* [Exuberant Ctags](http://ctags.sourceforge.net/)
* [Python](https://www.python.org/downloads/) (3.6 recommended)
* [D2Coding](https://github.com/naver/d2codingfont/releases/latest) 1.3+
    (recommended)
* `PATH` variable is set correctly

## Installation

    sudo apt install gdb tmux zsh unzip vim exuberant-ctags
    ./install
    # (Re)start Zsh

## pythonrc
Python prompts are colorized unless the interpreters are started directly on
Windows, or [ANSICON](https://github.com/adoxa/ansicon) and
[psutil](https://pypi.org/project/psutil/) are not installed.

## vimrc
### Clang on Windows
I use [Clang](http://releases.llvm.org/download.html) as the default C/C++
compiler. Modify the F5 key binding if you want MSVC/GCC or another.

### YouCompleteMe
The installer tries to install YouCompleteMe on supported systems. Refer to
[the manual page](https://github.com/Valloric/YouCompleteMe/blob/master/README.md)
to check the requirements.

    sudo apt install build-essential cmake python-dev python3-dev
    vim +PlugUpdate! +qa

The post-update hooks do not work on Windows. You can use `update-ycm.bat` to
update the build.

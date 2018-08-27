@echo off

pushd %USERPROFILE%\.vim\plugged\YouCompleteMe
python install.py --clang-completer
popd
pause

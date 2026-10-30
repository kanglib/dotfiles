function mkc -d 'mkdir and cd to it'
    command mkdir -p $argv[1]; and cd $argv[1]; or return 1
end

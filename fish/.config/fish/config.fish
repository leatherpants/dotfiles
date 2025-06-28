if status is-interactive
    # Commands to run in interactive sessions can go here
    starship init fish | source
end

set -x -U GOPATH $HOME/.go
set -x -U EDITOR nvim
set -x -U ALIYUNPAN_CONFIG_DIR /home/xuhan/.config/aliyunpan

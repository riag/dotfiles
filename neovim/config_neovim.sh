#!/bin/sh


config_neovim()
{
    echo "start config neovim"

    sh -c "$(wget -qO- https://raw.githubusercontent.com/liuchengxu/space-vim/master/install.sh)"

    dest_path=~/.config/nvim
    [ -d $dest_path ] || mkdir -p $dest_path
    dest_file_path=$dest_path/init.vim
    if [ ! -f "$dest_file_path" ];then
        ln -s ~/.space-vim/init.vim $dest_file_path
    fi

    echo "end config neovim"
}

config_neovim

echo "config neovim ok"

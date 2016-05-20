#!/bin/sh

# 会把 https://github.com/github/gitignore 预定义好的gitignore 合并到~/.gitignore
# 在 ./git/gitignore_list ./git/gitignore_list.local 定义要使用 https://github.com/github/gitignore 里的哪些文件
# 还可以在 ./gitignore.local 定义自己的gitignore

clone_or_update_gitingore(){
    local work_dir="`echo ~/.dotfiles`"
    if [ -d ~/.dotfiles/gitignore ];then
        echo "git pull for github/gitignore"
        git -C "`echo $work_dir/gitignore`" pull
    else
        echo "git clone for github/gitignore"
        git -C "`echo $work_dir`" clone https://github.com/github/gitignore
    fi
	local code=$?
	if [ $code != 0 ];then
        echo "clone or pull github/gitignore error" >&2
        exit 1
    fi
}

make_gitignore_by_file(){
    grep -v '^$\|^\s*\#' $1  |xargs ./handle_gitignore_files.sh ~/.dotfiles/gitignore
}

[ -d ~/.dotfiles ] || mkdir ~/.dotfiles

clone_or_update_gitingore

echo "" >~/.gitignore

make_gitignore_by_file "./git/gitignore_list"

if [ -f "./git/gitignore_list.local" ];then
    make_gitignore_by_file "./git/gitignore_list.local"
fi

cat "./git/gitignore" >> ~/.gitignore

if [ -f "./git/gitignore.local" ];then
    cat "./git/gitignore.local" >> ~/.gitignore
fi

git config --global core.excludesfile ~/.gitignore

echo "make gitignore successfully"

#!/bin/sh

#set -x

os_type=`uname -o`

# check git, make, python, ag, gcc
check_pro()
{
	local pro=""
	for pro in git make python ag gcc
	do
		local pro_path=`which $pro`
		if [ -z "$pro_path" ];then
			echo "please install $pro" >&2
			exit 1
		fi
	done
}


check_error_code()
{
	local code=$?
	local msg="$1"
	if [ $code != 0 ];then
		echo "error code: $code, message: $msg" >&2
		exit -1
	fi
}

config_vim()
{
	echo "start config vim"

	if [ ! -d "$HOME/.vimfiles" ];then
		git clone --recursive "https://github.com/riag/vimfiles" $HOME/.vimfiles
		check_error_code "git clone vimfiles error"
	else
		git -C $HOME/.vimfiles pull
		check_error_code "git pull vimfiles error"

		git -C $HOME/.vimfiles submodule update
		check_error_code "git submodule update vimfiles error"
	fi

	echo "source $HOME/.vimfiles/vimrc.vim" > $HOME/.vimrc
	local path="$HOME/.vimfiles/vimrc.vim.local"
	[ -f "$path" ] || cp "${path}.tpl" "$path"

	make -C "$HOME/.vimfiles/bundle/vimproc.vim"

	echo "end config vim"
}

config_zsh()
{
	echo "start config zsh"

	# install autojump
	if [ ! -d "$HOME/.autojump" ];then
		if [ ! -d "$HOME/autojump" ];then
			git clone --recursive "https://github.com/wting/autojump" $HOME/autojump
			check_error_code "git clone autojump error"
		else
			git -C $HOME/autojump pull
			check_error_code "git pull autojump error"
		fi

		sh -c "cd $HOME/autojump; python install.py"
		check_error_code "install autojump error"
	fi

	if [ ! -d "$HOME/.oh-my-zsh" ];then
		git clone --recursive "https://github.com/robbyrussell/oh-my-zsh" $HOME/.oh-my-zsh
		check_error_code "git clone oh-my-zsh error"
	else
		git -C $HOME/.oh-my-zsh pull
		check_error_code "git pull oh-my-zsh error"
	fi
	cp -rf zsh/zshrc $HOME/.zshrc
	touch $HOME/.zshrc.local

	echo "end config zsh"
}

config_tmux()
{
	echo "start config mtmux"

	cp -rf tmux/tmux.conf $HOME/.tmux.conf
	touch $HOME/.tmux.conf.local

	echo "end config mtmux"
}

config_mintty()
{
	echo "start config mintty"
	cp -rf mintty/minttyrc $HOME/.minttyrc
	echo "end config mintty"
}

check_pro

config_vim

config_zsh

config_tmux

if [ "$os_type" = "Cygwin" ];then
	config_mintty
fi

./make_gitignore.sh
check_error_code "make gitignore error"

echo "install ok"

#!/bin/sh

#set -x

os_type=`uname -o`

# check git, make, python, gcc
check_pro()
{
	local pro=""
	for pro in git make python gcc
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

  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
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

config_zsh

config_tmux

if [ "$os_type" = "Cygwin" ];then
	config_mintty
fi

./make_gitignore.sh
check_error_code "make gitignore error"

echo "install ok"

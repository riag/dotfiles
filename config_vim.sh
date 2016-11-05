#!/bin/sh

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

config_vim

echo "config vim ok"

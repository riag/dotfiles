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

# check git, make, python, ag, gcc
check_pro()
{
	local pro=""
	for pro in git 
	do
		local pro_path=`which $pro`
		if [ -z "$pro_path" ];then
			echo "please install $pro" >&2
			exit 1
		fi
	done
}

install_font()
{
	fonts_path="$HOME/powerline_fonts"

	if [ ! -d "$fonts_path" ];then
		git clone --recursive https://github.com/powerline/fonts $fonts_path	
		check_error_code "git clone powerline font error"
	else
		git -C "$fonts_path" pull
		check_error_code "git pull powerline fonts error"
	fi

	sh -c "cd $fonts_path; ./install.sh"
	check_error_code "install fonts error"
}

check_pro

install_font


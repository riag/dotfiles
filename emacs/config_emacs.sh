#!/bin/sh

emacs_home=~/.emacs.d
if [ -d "$emacs_home" ];then
    git -C $emacs_home pull
else
    git clone https://github.com/syl20bnr/spacemacs $emacs_home
fi

# spacemacs private config path
sph=~/.spacemacs.d
if [ -d "$sph" ];then
    git -C $sph pull
else
    git clone https://github.com/riag/spacemacs.d $sph
fi

echo "config emacs ok"

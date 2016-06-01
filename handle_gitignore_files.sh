#!/bin/sh

work_dir="$1"
shift

handle_one_gitignore_file(){
    local p="$work_dir/$1"
    echo "handle gitignore file $p"

    if [ -f $p ]; then
        cat $p >>~/.gitignore
    else
        echo "file $p not eixt" >&2
    fi
}


while [ "$1" != "" ]; 
    do case $1 in 
        * ) 
        handle_one_gitignore_file $1
    esac 
    shift 
done


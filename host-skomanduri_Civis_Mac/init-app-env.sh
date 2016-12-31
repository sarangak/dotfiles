#!/usr/bin/env zsh

# Used to set env vars for GUI applications like GUI Emacs
# From https://gist.github.com/yogsototh/2c67171d203fcbf55bc5373d77cc378e
source ~/.zshrc
for i in $(export); do
    var=$(echo $i|sed 's/=.*//')
    val=$(echo $i|sed 's/^[^=]*=//')
    [[ $val != "" ]] && {
        launchctl setenv $var $val
    }
done

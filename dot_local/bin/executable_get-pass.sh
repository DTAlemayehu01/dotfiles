#!/bin/sh
# https://github.com/dbrumbaugh/dotfiles/blob/master/scripts/.local/bin/get-pass

if [ "$#" = "1" ]; then
	printf '%q' "$(pass "$1" | head -1)"
else
	# Head to prevent extra matches
	printf '%q' "$(pass "$1" | awk -F ':' '/^$2/''{print $2}' | head -n 1)"
fi

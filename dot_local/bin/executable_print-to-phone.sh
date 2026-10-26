#!/bin/bash
# Use this to print stuff to phone
# Should go without saying, usb debugging needs to be enabled
# https://android.stackexchange.com/questions/19710/is-it-possible-to-write-to-a-devices-clipboard-using-adb

if [[ "$1" != "" ]]; then
	TEXT=$1
else
	read -s -p "Enter text you want to insert: " TEXT
fi

#ESCAPED_TEXT=${printf '%q' '$TEXT'}
ESCAPED_TEXT=$(echo $TEXT | sed "s/\s/\%s/g")
adb shell input text "$ESCAPED_TEXT"

#!/bin/zsh

WINDOWID=$(yabai -m query --windows | jq 'map(select(.title=="popup"))[0].id')
ISFOCUSED=$(yabai -m query --windows | jq 'map(select(.title=="popup"))[0]["has-focus"]')

if [ -n "$WINDOWID" ] && [ "$WINDOWID" -eq "$WINDOWID" ] 2>/dev/null; 
then
    if [ $ISFOCUSED = true ];
    then
        skhd -k "cmd - h"
        yabai -m window --focus recent;
    else
        yabai -m window "$WINDOWID" --move abs:270:450;
        yabai -m window --focus $WINDOWID;
    fi
else 
    /Applications/Alacritty.app/Contents/MacOS/alacritty -t popup -e ~/.config/scripts/scratchpad-startup.sh;
fi
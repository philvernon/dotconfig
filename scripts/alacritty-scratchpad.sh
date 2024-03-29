#!/bin/zsh

WINDOWID=$(yabai -m query --windows | jq 'map(select(.title=="popup"))[0].id')
ISFOCUSED=$(yabai -m query --windows | jq 'map(select(.title=="popup"))[0]["has-focus"]')

if [ -n "$WINDOWID" ] && [ "$WINDOWID" -eq "$WINDOWID" ] 2>/dev/null; 
then
  if [ $ISFOCUSED = true ];
  then
    skhd -k "cmd - h"
    yabai -m window --focus first;
  else
    yabai -m window --focus $WINDOWID;
    # yabai -m window "$WINDOWID" --move abs:70:575;
    if [[ $1 == "sbuild" ]];
    then
      if [[ ! $(tmux ls | grep sbuild) ]];
      then
        tmux send-keys -t scratch "sb" Enter
        tmux send-keys -t scratch "sb" Enter
      fi
      scratch_client=$(tmux list-clients | grep scratch | sed 's/:.*$//')
      tmux switch -t sbuild -c "$scratch_client"
    else
      scratch_client=$(tmux list-clients | grep sbuild | sed 's/:.*$//')
      tmux switch -t scratch -c "$scratch_client"
    fi
  fi
else 
  /Applications/Alacritty.app/Contents/MacOS/alacritty -t popup -e ~/.config/scripts/scratchpad-startup.sh $1
fi

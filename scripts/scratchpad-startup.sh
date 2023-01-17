yabai -m window --toggle float
yabai -m window --move abs:70:575
yabai -m window --resize abs:1300:300
yabai -m window --toggle border
yabai -m window --toggle sticky


# if [[ $1 == "sbuild" ]];
# then
#   if [[ $(tmux ls | grep 'sbuild') ]];
#   then
#     tmux switch -t sbuild
#   else
#     tmux send-keys -t scratch "sb" Enter
#     scratch_client=$(tmux list-clients | grep scratch | sed 's/:.*$//') 
#     tmux switch -t sbuild
#   fi
# fi

if [ ! "$TMUX" ]; 
then
  tmux attach -t scratch || tmux new -s scratch
fi

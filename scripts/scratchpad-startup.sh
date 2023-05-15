#!/bin/zsh

half_screen_width=$(system_profiler SPDisplaysDataType | awk '/Resolution/{print $2 / 2; exit}')
screen_height=$(system_profiler SPDisplaysDataType | awk '/Resolution/{print $4; exit}')
height=$(($screen_height / 2 / 100 * 40))
width=$(($half_screen_width * 1.5))
x_pos=$(($half_screen_width - ($width / 2)))
y_pos=$(($screen_height - $height - 10))

yabai -m window --toggle float
yabai -m window --move abs:$x_pos:$y_pos
yabai -m window --resize abs:$width:$height
yabai -m window --toggle border
yabai -m window --toggle sticky

if [ ! "$TMUX" ]; 
then
  tmux attach -t scratch || tmux new -s scratch
fi

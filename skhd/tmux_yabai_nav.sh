#!/usr/bin/env bash

direction="$1"

echo "ITS WORKING"

# If this pane is SSH, send Meta+direction through to the remote side.
pane_cmd="$(tmux display-message -p '#{pane_current_command}')"

if [[ "$pane_cmd" == "ssh" ]]; then
    case "$direction" in
				L) tmux send-keys M-h ;;
				D) tmux send-keys M-j ;;
				U) tmux send-keys M-k ;;
				R) tmux send-keys M-l ;;
    esac
    exit
fi

# Fallback to yabai window focus
case "$direction" in
    L) if [ $(tmux display-message -p '#{pane_at_left}') -ne 1 ]; then tmux select-pane -L; else yabai -m window --focus west || true; fi ;;
    R) if [ $(tmux display-message -p '#{pane_at_right}') -ne 1 ]; then tmux select-pane -R; else yabai -m window --focus east || true; fi || yabai -m window --focus recent ;; # go to recent if nothing east
    U) if [ $(tmux display-message -p '#{pane_at_top}') -ne 1 ]; then tmux select-pane -U; else yabai -m window --focus north || true; fi ;;
    D)  if [ $(tmux display-message -p '#{pane_at_bottom}') -ne 1 ]; then tmux select-pane -D; else yabai -m window --focus south || true; fi ;;
esac

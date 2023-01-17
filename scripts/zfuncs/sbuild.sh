#!/bin/bash

session="sbuild"
root="/Users/philipvernon/Documents/syn-repos/synthesis"

sbuild () {
  tmux has-session -t $session 2>/dev/null

  if [ $? == 0 ]; then
    tmux switch -t $session
  else
    tmux new-session -d -s $session
    tmux splitw -h -t $session
    tmux send-keys -t $session:0.0 "cd $root" Enter
    tmux send-keys -t $session:0.0 "./docker-compose-synthesis.sh" Enter
    tmux send-keys -t $session:0.1 "cd $root/web" Enter
    tmux send-keys -t $session:0.1 "npm run dev" Enter
  fi
}

#!/bin/bash

session_name="give"
tmux new-session -d -s "$session_name"

window_names=("nvim", "backend", "frontend", "yazi", "lazygit")
window_commands=({"", "cd backend" "cd react-client" "yazi", "lazygit"})

for i in "${!window_names[@]}"; do
    # Create a new window and name it
    tmux new-window -t "$session_name" -n "${window_names[$i]}"
    # Run a command in the new window
    tmux send-keys -t "$session_name:$i" "${window_commands[$i]}" ENTER
done

# Attach to the session
tmux attach-session -t "$session_name"

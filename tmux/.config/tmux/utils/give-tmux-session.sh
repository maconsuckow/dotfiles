#!/bin/bash

# Get the session name (default to folder name)
# tr '.' '_' handles hidden folders like .config
default_name=$(basename "$PWD" | tr '.' '_')

if [ $# -eq 0 ]; then
    session_name="$default_name"
    session_type="project"
else
    session_name="$1"
    if [ $# -ge 2 ]; then
        session_type="$2"
    else
        case "$1" in
            "config"|"obsidian"|"give") session_type="$1" ;;
            *) session_type="project" ;;
        esac
    fi
fi

# If session already exists, just attach
if tmux has-session -t "$session_name" 2>/dev/null; then
    tmux attach-session -t "$session_name"
    exit 0
fi

echo "Starting session: $session_name ($session_type)"

# Template Logic
case "$session_type" in
    "config")
        # Config Session
        tmux new-session -d -s "$session_name" -n "nvim" -c "$HOME/.config"
        tmux send-keys -t "$session_name:1" "nvim" C-m
        tmux new-window -t "$session_name" -n "gemini"
        ;;
    "obsidian")
        # Obsidian Session
        # Adjust the path below to your actual vault
        vault_path="$HOME/Documents/Personal"
        tmux new-session -d -s "$session_name" -n "notes" -c "$vault_path"
        tmux send-keys -t "$session_name:1" "nvim" C-m
        tmux new-window -t "$session_name" -n "gemini"
        ;;
    "give")
        repo_path="$HOME/development/giveinteractive/"
        # Standard Project Session
        tmux new-session -d -s "$session_name" -n "nvim" -c "$repo_path"
        tmux send-keys -t "$session_name:1" "nvim" C-m
        
        # Window 2: Backend (if exists)
        if [ -d "$repo_path/backend" ]; then
            tmux new-window -t "$session_name" -n "backend" -c "$repo_path/backend"
        else
            tmux new-window -t "$session_name" -n "backend" -c "$repo_path"
        fi
        
        # Window 3: Client (if exists)
        if [ -d "$repo_path/react-client" ]; then
            tmux new-window -t "$session_name" -n "client" -c "$repo_path/react-client"
        else
            tmux new-window -t "$session_name" -n "client" -c "$repo_path"
        fi
        
        # Window 4: DB
        tmux new-window -t "$session_name" -n "db" -c "$repo_path"
        
        # Window 5: Gemini
        tmux new-window -t "$session_name" -n "gemini" -c "$repo_path"
        ;;
    *)
        # Standard Project Session
        tmux new-session -d -s "$session_name" -n "nvim"
        tmux send-keys -t "$session_name:1" "nvim" C-m
        
        # Use current directory as root if repo_path is not defined
        root_path="."
        
        if [ -d "$root_path/api" ]; then
            tmux new-window -t "$session_name" -n "backend" -c "$root_path/api"
        else
            tmux new-window -t "$session_name" -n "backend" -c "$root_path"
        fi
        
        # Window 3: Client (if exists)
        if [ -d "$root_path/client" ]; then
            tmux new-window -t "$session_name" -n "client" -c "$root_path/client"
        else
            tmux new-window -t "$session_name" -n "client" -c "$root_path"
        fi
        
        # Window 4: DB
        tmux new-window -t "$session_name" -n "db" -c "$root_path"
        
        # Window 5: Gemini
        tmux new-window -t "$session_name" -n "gemini" -c "$root_path"
        ;;
esac

# Start at the editor
tmux select-window -t "$session_name:1"
tmux attach-session -t "$session_name"

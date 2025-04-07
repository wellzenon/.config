#!/bin/bash

# --- Configuration ---
# Keys Neovim expects for quit (e.g., <leader>q where leader is space)
# Adjust "space q" if your <leader> is not space or you chose a different keymap.
NVIM_QUIT_KEYS="F9"

# Window class for YOUR terminal emulator.
# Find with: xprop | grep WM_CLASS (then click the terminal)
# Use the *first* value in quotes, e.g., "ghostty", "Alacritty", "kitty"
TERMINAL_WM_CLASS="ghostty" # <-- IMPORTANT: Confirm this is correct for your terminal!

# The process name to look for in the process tree
NVIM_PROCESS_NAME="nvim"
# --- End Configuration ---

# Get active window ID
active_win_id=$(xdotool getactivewindow)
if [[ -z "$active_win_id" ]]; then
  i3-msg kill # Fallback
  exit 0
fi

# Get window class using the active window ID
win_class=$(xprop -id "$active_win_id" WM_CLASS | awk -F '"' '{print $2}')

# Check if the focused window is the target terminal emulator (case-insensitive)
if [[ "${win_class,,}" == "${TERMINAL_WM_CLASS,,}" ]]; then
  # Get the PID of the terminal process itself
  win_pid=$(xdotool getwindowpid "$active_win_id")

  if [[ -n "$win_pid" ]]; then
    # Check if NVIM_PROCESS_NAME exists in the process tree of the terminal's PID
    # pstree -ps <PID> shows the tree including process names (nvim) and PIDs
    # grep -q makes it quiet (no output), just returns exit status 0 if found, 1 if not
    if pstree -ps "$win_pid" | grep -q "$NVIM_PROCESS_NAME"; then
      # Found nvim running under this terminal: send the configured quit keys
      # Using --clearmodifiers is important!
      xdotool key --clearmodifiers --window "$activwin_id" "$NVIM_QUIT_KEYS"  "$NVIM_QUIT_KEYS" "$NVIM_QUIT_KEYS"
      exit 0 # Exit after successfully sending keys
    fi
    # If nvim wasn't found in the process tree, just fall through to the default kill
  fi
  # If we couldn't get PID, or nvim wasn't found, also fall through to the default kill
fi

# Default action: If it's not the target terminal OR nvim wasn't found inside it
i3-msg kill
exit 0

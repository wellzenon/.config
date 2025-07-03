#!/bin/bash

# --- Configuration ---
TERMINAL_WM_CLASS="ghostty"       # Window class of the target terminal
NVIM_PROCESS_NAMES="(nvim|notes)" # Process name for Neovim
QUIT_COMMAND='<F9>'               # Command to quit Neovim (:xa<CR>, :qa<CR>, :qa!<CR>)
# --- End Configuration ---

# --- Main Script ---
SHOULD_I3_KILL=1 # Assume fallback (i3-msg kill) unless Neovim is controlled

# Get active window XID
active_win_xid=${1:-$(xdotool getactivewindow)}

if [[ -z "$active_win_xid" ]]; then
    # If we can't get the window, fallback immediately
    i3-msg kill
    exit 1
fi

# Get window class to check if it's the target terminal
win_class=$(xprop -id "$active_win_xid" WM_CLASS | awk -F '"' '{print $2}')

if [[ "${win_class,,}" == "${TERMINAL_WM_CLASS,,}" ]]; then
    # It's the target terminal, try to find and control Nvim

    # Get PID of the terminal process itself
    term_pid=$(xdotool getwindowpid "$active_win_xid")
    if [[ -n "$term_pid" ]]; then

        # Find all nvim PIDs running as descendants of the terminal PID
        mapfile -t nvim_pids < <(pstree -ps "$term_pid" | grep -oE "${NVIM_PROCESS_NAMES}.*\([0-9]+\)" | grep -oE "[0-9]+")

        if [[ ${#nvim_pids[@]} -gt 0 ]]; then
            # Found potential Nvim PIDs, now look for the server socket

            server_path_found=0
            nvim_listen_address=""
            runtime_dir="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}" # Base dir for sockets

            if [[ -d "$runtime_dir" ]]; then
                # Try constructing potential server socket paths based on common pattern
                for pid_to_try in "${nvim_pids[@]}"; do
                    possible_server_path=(${runtime_dir}/nvim*.${pid_to_try}.0)

                    # Check if the path exists and is a socket file
                    if [[ -S "$possible_server_path" ]]; then
                        nvim_listen_address="$possible_server_path"
                        server_path_found=1
                        break # Use the first valid socket found
                    fi
                done
            fi # End check for runtime_dir

            if [[ "$server_path_found" -eq 1 ]]; then
                # Found a valid socket, attempt to send the quit command
                nvim --server "$nvim_listen_address" --remote-send "<C-\\><C-N>${QUIT_COMMAND}"
                nvim_exit_status=$?

                if [[ $nvim_exit_status -eq 0 ]]; then
                    # Successfully sent command to Nvim, prevent fallback kill
                    SHOULD_I3_KILL=0
                # else: Sending failed, SHOULD_I3_KILL remains 1 for fallback
                fi
            # else: No valid socket found, SHOULD_I3_KILL remains 1 for fallback
            fi
        # else: No nvim PIDs found, SHOULD_I3_KILL remains 1 for fallback
        fi
    # else: Could not get terminal PID, SHOULD_I3_KILL remains 1 for fallback
    fi
# else: Not the target terminal, SHOULD_I3_KILL remains 1 for fallback
fi

# Fallback action: If Neovim wasn't successfully controlled, kill the window via i3
if [[ "$SHOULD_I3_KILL" -eq 1 ]]; then
    i3-msg kill
fi

exit 0

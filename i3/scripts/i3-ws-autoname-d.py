#!/usr/bin/env python3
"""
Dynamically update i3wm workspace names based on running applications,
using Unicode icons defined directly within the script.
"""

import argparse
import re
from typing import Dict, Optional  # For type hinting

import i3ipc

# Type alias for better readability
IconDict = Dict[str, str]

# --- Icon Configuration (Edit Here) ---
# Maps lowercase regex patterns for window identifiers (class, instance, title)
# to the desired Unicode icon character.
APP_ICONS: IconDict = {
    # Browsers
    "firefox": "",
    "chromium.*": "",  # Regex example for chromium variants
    "google-chrome.*": "",
    "zen.*": "",
    # Terminals
    "x-terminal-emulator": "",
    "alacritty": "",
    "kitty": "",
    "gnome-terminal": "",
    "st": "",  # suckless terminal
    "ghostty": "",
    # Mail/Communication
    "thunderbird": "",
    "evolution": "",
    "signal": "",
    "discord": "ﭮ",  # Example Discord
    # Development
    "jetbrains-.*": "",  # Generic Jetbrains IDEs
    "pycharm": "",
    "code": "",  # VS Code (uses 'code' or 'VSCodium' etc.)
    "vim": "",
    "nvim": "",
    # File Managers
    "nautilus": "",
    "thunar": "",
    "dolphin": "",
    # Media
    "clementine": "",
    "spotify": "",
    "vlc": "嗢",
    # Other common apps
    "notes": "",
    "obsidian": "󱁉",
    # Fallback icon for windows that don't match any specific rule
    "_no_match": "󰀻",
}
# --- End Icon Configuration ---


def get_icon_for_window(leaf: i3ipc.Con, app_icons: IconDict) -> Optional[str]:
    """Try to find a specific icon character for the given window leaf."""
    # Prefer class, then instance, then title, then name for matching
    identifiers = (
        getattr(leaf, "name", None),
        getattr(leaf, "window_class", None),
        getattr(leaf, "window_instance", None),
        getattr(leaf, "window_title", None),
    )

    for identifier in identifiers:
        if identifier is None:
            continue
        # Check against regex patterns in app_icons
        for pattern, icon in app_icons.items():
            if pattern == "_no_match":
                continue
            try:
                if re.match(pattern, identifier, re.IGNORECASE):
                    return icon
            except re.error as e:
                print(f"Warning: Regex error for pattern '{pattern}': {e}")
                # Avoid matching this invalid pattern again
                app_icons[pattern] = "_invalid_regex_"  # Mark to skip
                continue  # Try next pattern

    return None  # No specific icon found


def get_window_name_or_icon(
    leaf: i3ipc.Con, app_icons: IconDict, max_length: int, show_name_for_no_match: bool
) -> str:
    """
    Return the specific icon, or the fallback icon + name, or just name, or fallback icon.
    """
    specific_icon = get_icon_for_window(leaf, app_icons)
    if specific_icon:
        return specific_icon

    # If no specific icon, decide on fallback representation
    fallback_icon = app_icons.get("_no_match")
    best_name = (
        leaf.name or leaf.window_title or leaf.window_instance or leaf.window_class
    )

    if best_name:
        if fallback_icon and show_name_for_no_match:
            return f"{fallback_icon} {best_name[:max_length]}"
        elif fallback_icon:
            return fallback_icon
        else:
            return best_name[:max_length]  # No fallback icon, just name
    else:
        # No name info available either
        return fallback_icon or "?"  # Fallback icon or literal '?'


def build_rename_callback(
    i3: i3ipc.Connection, app_icons: IconDict, args: argparse.Namespace
):
    """Builds the event handler function closure."""

    delim: str = args.delimiter
    max_len: int = args.max_title_length
    uniq: bool = args.uniq
    show_name: bool = not args.no_match_not_show_name
    verbose: bool = args.verbose

    def _rename_workspaces(i3_conn: i3ipc.Connection, event: Optional[i3ipc.Event]):
        """The actual callback function executed on i3 events."""
        try:
            workspaces = i3_conn.get_tree().workspaces()
            commands = []

            for ws in workspaces:
                window_reprs = [
                    get_window_name_or_icon(leaf, app_icons, max_len, show_name)
                    for leaf in ws.leaves()
                ]

                if uniq:
                    # Simple uniqueness filter, preserving order for the first occurrences
                    seen = set()
                    window_reprs = [
                        x for x in window_reprs if not (x in seen or seen.add(x))
                    ]

                joined_reprs = delim.join(window_reprs)

                if int(ws.num) >= 0:
                    # Numbered workspace: "1: icon | icon2"
                    new_name = f"{ws.num}: {joined_reprs}"
                else:
                    # Scratchpad or named workspace: "icon | icon2"
                    new_name = joined_reprs

                if ws.name != new_name:
                    # Escape double quotes in names for the i3 command
                    escaped_old = ws.name.replace('"', '\\"')
                    escaped_new = new_name.replace('"', '\\"')
                    cmd = f'rename workspace "{escaped_old}" to "{escaped_new}"'
                    commands.append(cmd)
                    if verbose:
                        print(f"Command: {cmd}")

            if commands:
                # Execute commands in one batch to prevent potential race conditions
                reply = i3_conn.command(";".join(commands))
                for item in reply:
                    if not item.success:
                        print(f"Error executing rename command part: {item.error}")

        except Exception as e:
            # Catch potential errors during processing (e.g., i3 connection issue)
            print(f"Error during workspace rename: {e}")

    return _rename_workspaces


def _verbose_startup_info(i3: i3ipc.Connection):
    """Prints detailed window information for debugging icon mappings."""
    print("\n--- Verbose Startup Info ---")
    for ws in i3.get_tree().workspaces():
        print(f'WORKSPACE: "{ws.name}" (Num: {ws.num})')
        if not ws.leaves():
            print("  (empty)")
        for i, leaf in enumerate(ws.leaves()):
            print(f"  LEAF {i}:")
            print(f"  -> name: {leaf.name}")
            print(f"  -> window_title: {leaf.window_title}")
            print(f"  -> window_class: {leaf.window_class}")
            print(f"  -> window_instance: {leaf.window_instance}")
    print("----------------------------\n")


def main():
    """Main function to parse arguments, set up i3 connection and callbacks."""
    parser = argparse.ArgumentParser(
        description=__doc__, formatter_class=argparse.ArgumentDefaultsHelpFormatter
    )
    parser.add_argument(
        "-d",
        "--delimiter",
        default=" | ",
        help="Delimiter between icons/names in the workspace.",
    )
    parser.add_argument(
        "-l",
        "--max_title_length",
        default=10,
        type=int,
        help="Max length for window names when shown.",
    )
    parser.add_argument(
        "-u",
        "--uniq",
        action="store_true",
        default=False,
        help="Remove duplicate icons/names within a workspace.",
    )
    parser.add_argument(
        "-n",
        "--no-match-not-show-name",
        action="store_true",
        default=False,
        help="Use only the fallback icon (if set) for unmatched windows, don't append the window name.",
    )
    parser.add_argument(
        "-v",
        "--verbose",
        action="store_true",
        default=False,
        help="Print verbose output, including commands and startup window info.",
    )
    args = parser.parse_args()

    # Normalize the icon map keys once at the start
    # Use a copy to avoid modifying the original constant during regex error handling
    active_app_icons = {k.lower(): v for k, v in APP_ICONS.items()}

    try:
        i3 = i3ipc.Connection()
    except Exception as e:
        print(f"Error connecting to i3: {e}")
        exit(1)

    if args.verbose:
        _verbose_startup_info(i3)

    # Create the actual rename callback function
    rename_callback = build_rename_callback(i3, active_app_icons, args)

    # Run initial rename to set names correctly at startup
    print("Performing initial workspace rename...")
    rename_callback(i3, None)
    print("Initial rename done.")

    # Subscribe to events that change window presence or titles
    events_to_subscribe = [
        i3ipc.Event.WINDOW_NEW,
        i3ipc.Event.WINDOW_CLOSE,
        i3ipc.Event.WINDOW_MOVE,
        i3ipc.Event.WINDOW_TITLE,
        i3ipc.Event.WORKSPACE_FOCUS,  # Update when switching workspaces too
    ]

    for event_type in events_to_subscribe:
        i3.on(event_type, rename_callback)

    print(f"Listening for i3 events: {[e.value for e in events_to_subscribe]}...")
    i3.main()  # Start the main event loop


if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        print("\nExiting script.")

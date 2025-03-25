#!/usr/bin/env bash

# Register VS Code URL handler
xdg-mime default vscode-url-handler.desktop x-scheme-handler/vscode
xdg-mime default vscode-url-handler.desktop x-scheme-handler/vscode-insiders

# Register Cursor URL handlers
xdg-mime default cursor-url-handler.desktop x-scheme-handler/cursor
xdg-mime default cursor-url-handler.desktop x-scheme-handler/cursor-insiders

# Update the MIME database
update-desktop-database ~/.local/share/applications

echo "URL handlers registered successfully!" 

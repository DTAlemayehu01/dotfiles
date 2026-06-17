#!/bin/bash

chezmoi update
chezmoi -R apply
chezmoi merge-all
yay -Syu
doom sync
doom upgrade
rustup update
hyprpm update
flatpak update

# Better for first time setup?
gsettings set org.gnome.desktop.interface gtk-theme "Dracula"
gsettings set org.gnome.desktop.wm.preferences theme "Dracula" 

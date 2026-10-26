#!/bin/bash

chezmoi update
chezmoi merge-all
chezmoi -R apply
yay -Syu
doom sync
doom upgrade
rustup update
hyprpm update
flatpak update

# Better for first time setup?
gsettings set org.gnome.desktop.interface gtk-theme "Dracula"
gsettings set org.gnome.desktop.wm.preferences theme "Dracula" 

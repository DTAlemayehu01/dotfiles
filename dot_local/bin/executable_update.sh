#!/bin/bash

chezmoi -R apply
yay -Syyu
doom sync
doom upgrade
rustup update
hyprpm update
flatpak update

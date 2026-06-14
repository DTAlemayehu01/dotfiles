#!/bin/bash

chezmoi -R apply
yay -Syu
doom sync
doom upgrade
rustup update
hyprpm update
flatpak update

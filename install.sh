#!/bin/bash

#################### Packages ####################

# List of packages to install
# Pre-Wayland packages: "i3-gaps" "picom" "dunst" "nitrogen"

packages=("sway" "swaylock" "waybar" "alacritty" "rofi" "fish" "bat" "fd" "fzf" "xorg-server-xwayland", "nerd-fonts-fira-code")

echo "Install packages? This will install the following packages and their dependencies using pacman. This requires sudo (y/n):"
printf '%s\n' "${packages[@]}"
read -r
echo

if [[ $REPLY =~ ^[Yy]$ ]]
then
    sudo pacman -Syu ${packages[*]}
fi

#################### Config Symlinks ####################

read -p "Symlink files and directories? (y/n)" -r
echo

if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo "============================"
    echo "===== Symlinking files ====="
    echo "============================"

    files=(".config/starship.toml")

    for i in "${files[@]}"
    do
        rm -f ~/$i
        echo ~/dotfiles/$i "==>" ~/$i
        ln -sf ~/dotfiles/$i ~/$i
    done

    echo -e "\n==========================="
    echo "===== Symlinking dirs ====="
    echo "==========================="

    dirs=("sway" "alacritty" "bat" "rofi" "fish" "waybar" "mako")

    for i in "${dirs[@]}"
    do
        rm -f ~/.config/$i
        echo ~/dotfiles/$i "==>" ~/.config/$i
        ln -sf ~/dotfiles/$i ~/.config/$i
    done
fi

#################### Fish ####################

echo
read -p "Set Fish as default shell? (y/n)" -r
echo

if [[ $REPLY =~ ^[Yy]$ ]]
then
    chsh -s $(which fish)
fi

# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

echo -e "\n==========================="
echo "======== Complete! ========"
echo "==========================="
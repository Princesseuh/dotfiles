#!/bin/bash

#################### Packages ####################

# List of packages to install
# Pre-Wayland packages: "i3-gaps" "picom" "dunst" "nitrogen"

packages=("sway" "swaylock" "swaybg" "swayidle" "waybar" "alacritty" "rofi" "fish" "bat" "fd" "fzf" "xorg-server-xwayland" "polkit-gnome" "otf-font-awesome")

echo "Install packages? This will install the following packages and their dependencies using pacman. This requires sudo (y/n) "
printf '%s\n' "${packages[@]}"
read -r
echo

if [[ $REPLY =~ ^[Yy]$ ]]
then
    sudo pacman -Syu ${packages[*]}
fi

#################### Config Symlinks ####################

read -p "Symlink files and directories? (y/n)
WARNING: This can result in data loss, make sure to backup your current settings if they exist! " -r
echo

if [[ $REPLY =~ ^[Yy]$ ]]
then
    # echo "============================"
    # echo "===== Symlinking files ====="
    # echo "============================"

    # files=(".config/starship.toml")

    # for i in "${files[@]}"
    # do
    #     rm -f ~/$i
    #     echo ~/dotfiles/$i "==>" ~/$i
    #     ln -sf ~/dotfiles/$i ~/$i
    # done

    echo -e "\n==========================="
    echo "===== Symlinking dirs ====="
    echo "==========================="

    dirs=("linux/sway" "linux/foot" "shared/bat" "linux/rofi" "shared/fish" "linux/waybar" "linux/mako" "shared/htop" "linux/pacman")

    for i in "${dirs[@]}"
    do
        clean=${i//'linux/'}
        clean=${clean//'shared/'}
        rm -f ~/.config/$clean
        echo ~/dotfiles/$i "==>" ~/.config/$clean
        ln -sf ~/dotfiles/$i ~/.config/$clean
    done
fi

#################### Fish ####################

echo
read -p "Set Fish as default shell? (y/n) " -r
echo

if [[ $REPLY =~ ^[Yy]$ ]]
then
    chsh -s $(which fish)
    fish -i -c "set -U fish_user_paths $HOME/dotfiles/shared/scripts $fish_user_paths"
    fish -i -c "set -U fish_user_paths $HOME/dotfiles/linux/scripts $fish_user_paths"
fi

# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

echo -e "\n==========================="
echo "======== Complete! ========"
echo "==========================="

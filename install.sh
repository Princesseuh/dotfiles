#!/bin/bash

get_abs_filename() {
  # $1 : relative filename
  echo "$(cd "$(dirname "$1")" && pwd)/$(basename "$1")"
}

#################### Packages ####################

# List of packages to install
packages=("i3-gaps" "alacritty" "dunst" "rofi" "fish" "bat" "fd" "fzf" "nitrogen" "python-dbus")

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

    read -p "Install xkbmap? (y/n)" -r
    echo

    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        files=( "${files[@]}" ".xkbmap")
    fi

    for i in "${files[@]}"
    do
        rm -f ~/$i
        echo ~/dotfiles/$i "==>" ~/$i
        ln -sf ~/dotfiles/$i ~/$i
    done

    echo -e "\n==========================="
    echo "===== Symlinking dirs ====="
    echo "==========================="

    dirs=("alacritty" "bat" "dunst" "i3" "polybar" "rofi" "fish" "picom")

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
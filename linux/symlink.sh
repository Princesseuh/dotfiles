#!/bin/bash

#################### Config Symlinks ####################

read -p "Symlink files and directories? (y/n)
WARNING: This can result in data loss, make sure to backup your current settings if they exist! " -r
echo

if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo -e "\n==========================="
    echo "===== Symlinking dirs ====="
    echo "==========================="

    dirs=("linux/foot" "shared/bat" "shared/fish" "shared/htop" "linux/pacman" "shared/zed" "linux/niri" "linux/DankMaterialShell" "shared/rstask")

    for i in "${dirs[@]}"
    do
        clean=${i//'linux/'}
        clean=${clean//'shared/'}
        rm -rf ~/.config/$clean
        echo ~/dotfiles/$i "==>" ~/.config/$clean
        ln -sf ~/dotfiles/$i ~/.config/$clean
    done

    echo -e "\n=============================="
    echo "===== Symlinking files ====="
    echo "=============================="

    files=("linux/spotify-launcher/spotify-launcher.conf")

    for i in "${files[@]}"
    do
        filename=$(basename "$i")
        rm -f ~/.config/$filename
        echo ~/dotfiles/$i "==>" ~/.config/$filename
        ln -sf ~/dotfiles/$i ~/.config/$filename
    done

    echo -e "\n==================================="
    echo "===== Symlinking nested files ====="
    echo "==================================="

    nested_files=("shared/herdr/config.toml::herdr/config.toml")

    for i in "${nested_files[@]}"
    do
        src=${i%%::*}
        dest=${i##*::}
        mkdir -p ~/.config/$(dirname "$dest")
        rm -f ~/.config/$dest
        echo ~/dotfiles/$src "==>" ~/.config/$dest
        ln -sf ~/dotfiles/$src ~/.config/$dest
    done
fi

# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

echo -e "\n==========================="
echo "======== Complete! ========"
echo "==========================="

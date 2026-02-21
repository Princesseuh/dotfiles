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

    dirs=("shared/bat" "shared/fish" "shared/htop" "shared/zed" "shared/ghostty" "macOS/linearmouse" "shared/rstask")

    for i in "${dirs[@]}"
    do
        clean=${i//'macOS/'}
        clean=${clean//'shared/'}
        rm -rf ~/.config/$clean
        echo ~/dotfiles/$i "==>" ~/.config/$clean
        ln -sf ~/dotfiles/$i ~/.config/$clean
    done

    echo -e "\n==========================="
    echo "===== Symlinking scripts ====="
    echo "==========================="

    mkdir -p ~/.local/bin
    for f in ~/dotfiles/macOS/scripts/*; do
        script=$(basename "$f")
        echo ~/dotfiles/macOS/scripts/$script "==>" ~/.local/bin/$script
        ln -sf ~/dotfiles/macOS/scripts/$script ~/.local/bin/$script
    done
fi

# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

echo -e "\n==========================="
echo "======== Complete! ========"
echo "==========================="

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

    dirs=("shared/bat" "shared/fish" "shared/git" "shared/htop" "shared/zed" "shared/ghostty" "macOS/linearmouse" "shared/rstask" "macOS/skhd")

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
    for f in ~/dotfiles/shared/scripts/* ~/dotfiles/macOS/scripts/*; do
        script=$(basename "$f")
        echo "$f" "==>" ~/.local/bin/$script
        ln -sf "$f" ~/.local/bin/$script
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

    echo -e "\n========================================"
    echo "===== Symlinking home files ====="
    echo "========================================"

    home_files=("shared/claude/settings.json::.claude/settings.json" "shared/claude/skills::.claude/skills")

    for i in "${home_files[@]}"
    do
        src=${i%%::*}
        dest=${i##*::}
        mkdir -p ~/$(dirname "$dest")
        rm -rf ~/$dest
        echo ~/dotfiles/$src "==>" ~/$dest
        ln -sf ~/dotfiles/$src ~/$dest
    done
fi

# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

echo -e "\n==========================="
echo "======== Complete! ========"
echo "==========================="

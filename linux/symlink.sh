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

    dirs=("linux/foot" "shared/bat" "shared/fish" "linux/ghostty" "shared/git" "shared/htop" "linux/pacman" "shared/zed" "linux/niri" "linux/DankMaterialShell" "shared/rstask" "linux/pipewire" "linux/xremap")

    for i in "${dirs[@]}"
    do
        clean=${i//'linux/'}
        clean=${clean//'shared/'}
        rm -rf ~/.config/$clean
        echo ~/dotfiles/$i "==>" ~/.config/$clean
        ln -sf ~/dotfiles/$i ~/.config/$clean
    done

    echo -e "\n==========================="
    echo "===== Symlinking scripts ====="
    echo "==========================="

    mkdir -p ~/.local/bin
    for f in ~/dotfiles/shared/scripts/* ~/dotfiles/linux/scripts/*; do
        [ -e "$f" ] || continue
        script=$(basename "$f")
        echo "$f" "==>" ~/.local/bin/$script
        ln -sf "$f" ~/.local/bin/$script
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

    echo -e "\n========================================"
    echo "===== Symlinking home files ====="
    echo "========================================"

    home_files=("shared/claude/settings.json::.claude/settings.json" "shared/claude/CLAUDE.md::.claude/CLAUDE.md")

    for i in "${home_files[@]}"
    do
        src=${i%%::*}
        dest=${i##*::}
        mkdir -p ~/$(dirname "$dest")
        rm -rf ~/$dest
        echo ~/dotfiles/$src "==>" ~/$dest
        ln -sf ~/dotfiles/$src ~/$dest
    done

    echo -e "\n========================================"
    echo "===== Symlinking Claude dirs ====="
    echo "========================================"

    # Other tools (e.g. herdr) install into these dirs, so link entries individually and leave the dirs real.
    claude_dirs=("skills" "commands" "hooks")

    for d in "${claude_dirs[@]}"
    do
        [ -L ~/.claude/$d ] && rm ~/.claude/$d
        mkdir -p ~/.claude/$d
        for entry in ~/dotfiles/shared/claude/$d/*; do
            [ -e "$entry" ] || continue
            name=$(basename "$entry")
            rm -rf ~/.claude/$d/$name
            echo "$entry" "==>" ~/.claude/$d/$name
            ln -sf "$entry" ~/.claude/$d/$name
        done
    done
fi

# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

echo -e "\n==========================="
echo "======== Complete! ========"
echo "==========================="

#!/bin/bash

#################### Packages ####################

# List of packages to install

packages=("fish" "zoxide" "hyperfine")

echo "Install packages? This will install the following packages and the Iosevka font using homebrew (y/n) "
printf '%s\n' "${packages[@]}"
read -r
echo

if [[ $REPLY =~ ^[Yy]$ ]]
then
    brew install ${packages[*]}

    # Install Iosevka
    brew tap homebrew/cask-fonts
    brew install --cask font-iosevka
fi

#################### Config Symlinks ####################

read -p "Symlink files and directories? (y/n)
WARNING: This can result in data loss, make sure to backup your current settings if they exist! " -r
echo

if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo -e "\n==========================="
    echo "===== Symlinking dirs ====="
    echo "==========================="

    dirs=("shared/bat" "shared/fish" "shared/htop")

    for i in "${dirs[@]}"
    do
        clean=${i//'macOS/'}
        clean=${clean//'shared/'}
        rm -f $HOME/.config/$clean
        echo $HOME/dotfiles/$i "==>" $HOME/.config/$clean
        ln -sf $HOME/dotfiles/$i $HOME/.config/$clean
    done
fi

############### Keyboard Layout ###############

read -p "Install custom keyboard layout? (y/n) " -r
echo

if [[ $REPLY =~ ^[Yy]$ ]]
then
    ln -sf $HOME/dotfiles/macOS/KeyboardLayout.keylayout "$HOME/Library/Keyboard Layouts/KeyboardLayout.keylayout"
fi

#################### Fish ####################

# On macOS we don't ask if we should use Fish as a default shell
# I prefer to use the vanilla settings to avoid issues

echo "Adding Homebrew binaries and scripts to Fish's fish_user_paths. Don't forget to do add_abbreviations after booting Fish for the first time!"
/opt/homebrew/bin/fish -i -c "fish_add_path /opt/homebrew/bin; fish_add_path $HOME/dotfiles/shared/scripts; fish_add_path $HOME/dotfiles/macOS/scripts;"

# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

echo -e "\n==========================="
echo "======== Complete! ========"
echo "==========================="

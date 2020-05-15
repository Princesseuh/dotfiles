# Dotfiles

## Configuration:

- Distribution: Arch Linux
- WM: [i3-gaps](https://github.com/Airblader/i3)
- Bar: [Polybar](https://github.com/polybar/polybar)
- Compositor: [Picom](https://github.com/yshui/picom)
- Terminal Emulator: [Alacritty](https://github.com/polybar/polybar)
- Shell: [Fish](https://fishshell.com/)

## Installing

A script to automatically install the dotfiles (install packages and do symlinks) exist (`install.sh`) however, it makes the following assumptions:

- You're using Arch Linux (internally use pacman to install packages)
- You want to install all the files, you can't select specific features but you can choose not to do symlinks and do those manually
- Your dotfiles are located at `~/dotfiles` (only required for symlinking)

Also, the install script doesn't install packages and dependencies only available in the AUR, you'll have to install those manually. They are listed below. An AUR helper will not be installed.

**Important**: When doing symlinking, the script will FORCE DELETE (`rm -f`) files before doing the links. This might result in data loss if you're not careful. Beware!

## Requirements:
- [polybar](https://aur.archlinux.org/packages/polybar/) for the bar. Simple!
- [polybar-spotify](https://github.com/Jvanrhijn/polybar-spotify) to show currently playing song in the bar, place in the `polybar` folder.
- [Siji Font](https://aur.archlinux.org/packages/siji-git/), used for the glyphs in the bar
- [Unifont](https://aur.archlinux.org/packages/ttf-unifont/?setlang=pt_PT), also used for the glyphs in the bar

As with many i3 configuration, a bunch of programs are launched automatically at startup through i3's config file, some of these are core (but not necessarily required) such as polybar and dunst while some are purely things I personally use (for exemple, Spotify). Before blindly installing, I suggest making sure which entries you need as they are not configurable through the install script

This setup also use [pywal](https://github.com/dylanaraps/pywal) to automatically generate a color scheme based on my wallpaper. All the config files are based on the color scheme generated so if you're using another wallpaper / no wallpaper, your setup will probably look a little funny
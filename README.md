# Dotfiles

![Screenshot](screenshot.png)

## Configuration:

- Distribution: [Arch Linux](https://www.archlinux.org/)
- WM: [Sway](https://github.com/swaywm/sway)
- Bar: [Waybar](https://github.com/Alexays/Waybar/)
- Terminal: [Alacritty](https://github.com/alacritty/alacritty)
- Shell: [Fish](https://fishshell.com/)
- Launcher: [Rofi](https://github.com/davatorium/rofi/)

*Notes*: This is a [Wayland](https://gitlab.freedesktop.org/wayland) setup. Configs I used before switching to Wayland can be found in the [_old folder](./_old)

## Installing

A relatively bare-bone script to automatically install the dotfiles (install packages and do symlinks) exist ([install.sh](./install.sh)) however, it makes the following assumptions:

- You're using Arch Linux (internally use pacman to install packages)
- You want to install all the files, you can't select specific features but you can choose not to do symlinks and do those manually
- Your dotfiles are located at `~/dotfiles` (only required for symlinking)

⚠️ **Important: When doing symlinking, the script will FORCE DELETE  (`rm -f`) files before doing the links. This might result in data loss if you're not careful. Beware!**

### AUR

The install script doesn't install packages and dependencies only available in the AUR, you'll have to install those manually. An AUR helper will also not be installed [(I recommend yay if one is needed)](https://github.com/Jguer/yay)

- [autotiling](https://aur.archlinux.org/packages/autotiling) switch the split orientation automatically based on current window dimensions (like bspwm and dwm).
    - [An alternative to this with better performance](https://github.com/chmln/i3-auto-layout) exists, I haven't personally tried it however
- [grimshot](https://aur.archlinux.org/packages/grimshot/), for the screenshot features (super[+shift]+p). Technically, this file is already included in Sway so it isn't necessarily needed, however this makes it much easier to use by making a symlink in `/usr/bin` and installing the man page
- [ttf-iosevka](https://aur.archlinux.org/packages/ttf-iosevka), [ttf-iosevka-slab](https://aur.archlinux.org/packages/ttf-iosevka-slab) and [ttf-iosevka-term-slab](https://aur.archlinux.org/packages/ttf-iosevka-term-slab). The normal version (`ttf-iosevka`) is used in my code editor (using the extended variant), the serif version (`ttf-iosevka-slab`) is used in the bar, window title etc and the terminal serif version (`ttf-iosevka-term-slab`) is used in the terminal.

A [list](https://wiki.archlinux.org/index.php/Pacman/Tips_and_tricks#Install_packages_from_a_list) of the AUR packages required can be found in the [aur-packages](./aur-packages) file

## Tips and troubleshooting

### Autostart

Make sure to checkout the [autostart](./sway/autostart) file located in the [sway](./sway) folder and removing the entries you don't need.

Only the `wal` line is needed for the setup to work since this setup use [pywal](https://github.com/dylanaraps/pywal) to automatically generate a color scheme based on my wallpaper. All the config files are based on the color scheme generated so if you're using another wallpaper / no wallpaper, your setup might look a little funny

### Keyboard layout

In the same way, the keyboard layout is hardcoded in [/sway/config](./sway/config) in the "Input configuration" section, feel free to change accordingly to your layout (mine is the French Canadian layout with caps lock remapped to Escape)

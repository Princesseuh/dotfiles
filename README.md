# Dotfiles

## Configuration:

- Distribution: Ubuntu (at work), ArchLinux (at home)
- WM: [i3-gaps](https://github.com/polybar/polybar)
- Bar: [Polybar](https://github.com/polybar/polybar)
- Compositor: None (at work), Compton (at home)
- Terminal Emulator: [Alacritty](https://github.com/polybar/polybar)
- Shell: Fish

## Requirements:
- [polybar-spotify](https://github.com/Jvanrhijn/polybar-spotify) to show currently playing song in the bar, place in the `polybar` folder
- [Fisher](https://github.com/jorgebucaran/fisher) to manage Fish plugins (a `fishfile` is included)
- [fzf](https://github.com/junegunn/fzf) fuzzy file finder, required by [fish-fzf](https://github.com/jethrokuan/fzf)
- [fd](https://github.com/sharkdp/fd) alternative to `find`, used for the find file command of fish-fzf. Remove the `FZF_FIND_FILE_COMMAND` redefinition in `fish/conf.d/fzf.fish` if you don't want it.

As with many i3 configuration, a bunch of programs are launched automatically at startup through i3's config file, some of these are core (but not necessarily required) such as polybar and dunst while some are purely things I personally use (for exemple, Spotify). Before blindly installing, I suggest making sure which entries you need to avoid errors.

This setup also use [pywal](https://github.com/dylanaraps/pywal) to automatically generating a color scheme based on my [wallpaper](wallpaper/wallpaper.png). All the config files are based on the color scheme generated so if you're using another wallpaper, your setup will probably look a little funny.

Currently, no script to automatically install the dotfiles + dependencies exist

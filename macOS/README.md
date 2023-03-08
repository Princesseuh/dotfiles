# macOS dotfiles

TODO: Add screenshot

## Configuration

- Computer: MacBook Air M1 2020
- Terminal: Terminal.app
- Shell: [Fish](https://fishshell.com/)

## Installing

A relatively bare-bone (and not always so reliable) script to automatically install the dotfiles (install packages and do symlinks) exist ([install.sh](./install.sh)) however, it makes the following assumptions:

- [Homebrew](https://brew.sh/) is already installed and ready to be used
- You want to install all the files, you can't select specific features but you can however choose not to do symlinks and do those manually
- Your dotfiles are located at `~/dotfiles` (only required for automatic symlinking)

⚠️ **Important: When doing symlinking, the script will FORCE DELETE (`rm -f`) files before doing the links. This might result in data loss if you're not careful. Beware!**

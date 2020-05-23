# fish-fzf settings
set -gx FZF_LEGACY_KEYBINDINGS 0
set -gx FZF_ENABLE_OPEN_PREVIEW 1

set -U FZF_FIND_FILE_COMMAND "fd --type f --hidden --no-ignore-vcs --follow --exclude ".git" --color=always . \$dir"
set -U FZF_FIND_FILE_OPTS "--ansi --preview-window 'right:60%' --preview 'bat --color=always --style="numbers,grid" --line-range :300 {}'"
set -u FZF_OPEN_OPTS "$FZF_FIND_FILE_OPTS"

# Keybindings because I can't remember them
# Ctrl-o          Find a file.
# Ctrl-r          Search through command history.
# Alt-c           cd into sub-directories (recursively searched).
# Alt-Shift-c     cd into sub-directories, including hidden ones.
# Alt-o           Open a file/dir using default editor ($EDITOR)
# Alt-Shift-o     Open a file/dir using xdg-open or open command
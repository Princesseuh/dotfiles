# fish-fzf settings
set -gx FZF_LEGACY_KEYBINDINGS 0
set -gx FZF_ENABLE_OPEN_PREVIEW 1

set -U FZF_FIND_FILE_COMMAND "fd --type f --hidden --no-ignore-vcs --follow --exclude ".git" --color=always . \$dir"
set -U FZF_FIND_FILE_OPTS "--ansi --preview-window 'right:60%' --preview 'bat --color=always --style="numbers,grid" --line-range :300 {}'"
set -u FZF_OPEN_OPTS "$FZF_FIND_FILE_OPTS"
# fish-fzf settings
set -gx FZF_LEGACY_KEYBINDINGS 0
set -gx FZF_ENABLE_OPEN_PREVIEW 1

set -U FZF_FIND_FILE_COMMAND "fd --type f --hidden --no-ignore-vcs --exclude ".git" . \$dir"
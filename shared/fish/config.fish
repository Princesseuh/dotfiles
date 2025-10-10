# Start Sway at login if running from tty1 on Linux
if status is-login && test (uname) = Linux
  set TTY1 (tty)
  if test -z "$DISPLAY"; and test $TTY1 = /dev/tty1
    launch-sway
  end
end

# Fish settings
set -U fish_greeting

# Colors
set fish_color_command 5863A6
set fish_color_param 5F68A1
set fish_color_error A84055
set fish_color_quote 6753A6
set fish_color_escape 9E80FF
set fish_color_search_match --background='605C73'
set fish_pager_color_description 928181
set fish_pager_color_completion d1b9b9
set fish_pager_color_progress d1b9b9 --background='48425D'
set fish_color_autosuggestion brblack

if status is-interactive
  # We only load up the wal config on Linux
  if test (uname) = Linux; and not test "$TERM_PROGRAM" = vscode
    cat ~/.cache/wal/sequences &
  end

  # Load Fisher plugins
  for file in $fisher_path/conf.d/*.fish
    builtin source $file 2>/dev/null
  end

  zoxide init fish | source

	string match -q "$TERM_PROGRAM" "vscode"
	and . (code --locate-shell-integration-path fish)

	source $HOME/.config/fish/abbr.fish

  # Load local config
  source $HOME/.config/fish/local.fish
end

# source /opt/homebrew/opt/asdf/libexec/asdf.fish

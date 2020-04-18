# If fzf is installed, set it up
if type fzf > /dev/null 2>&1; then
  # Load default config files (completion and key bindings)
  # Completion at https://github.com/junegunn/fzf#fuzzy-completion-for-bash-and-zsh
  # Key bindings at https://github.com/junegunn/fzf#key-bindings-for-command-line
  source "$(fzf-share)/completion.zsh"
  source "$(fzf-share)/key-bindings.zsh"

  # TODO: Fix minor bug which doesn't display VCS info
  function cd_to_ranger_bookmark() {
    local directory
    directory=$(cat "$HOME/dotfiles/ranger/.config/ranger/bookmarks" | sed -n "s/.*:\(.*\)$/\1/p" | sort | fzf)

    cd "$directory" || exit

    zle && zle reset-prompt
  }

  # Define keybind CTRL+G to cd to ranger bookmark
  zle -N cd_to_ranger_bookmark
  bindkey '^g' cd_to_ranger_bookmark
fi

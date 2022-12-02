# User configuration for fzf

{ config, ... }:

let
  # Colors, Solarized Light
  # black = "#002B36";
  # cyan = "#2AA198";
  # dark_beige = "#EEE8D5";
  # magenta = "#D33682";
  # orange = "#CB4B16";
  # red = "#DC322F";
  # violet = "#6C71C4";
  blue = "#268BD2";
  green = "#859900";
  grey = "#839496";
  light_beige = "#FDF6E3";
  yellow = "#B58900";
in
{
  programs.fzf = {
    enable = true;
    # Default command for the ALT+C key binding
    # Only list directories which aren't ignored by VCS. The `.git` directory is always ignored.
    changeDirWidgetCommand = "command fd --hidden --type directory --exclude .git";
    # Default command to use when input is tty
    # Only list files which aren't ignored by VCS. Files under the `.git` directory are always ignored.
    defaultCommand = "command fd --hidden --type file --exclude .git";
    defaultOptions = [
      # Keybinds to select, deselect and toggle all results
      "--bind ctrl-a:select-all,ctrl-d:deselect-all,ctrl-t:toggle-all"
      # When fzf is opened, press Ctrl-f to show all files, even those ignored by VCS. Press Ctrl-g to revert this.
      "--bind 'ctrl-f:reload(${config.programs.fzf.defaultCommand} --no-ignore-vcs),ctrl-g:reload(${config.programs.fzf.defaultCommand})'"
      # Default layout (fullscreen and input from top)
      "--min-height=100 --reverse"
      # Default colors
      "--color fg:${grey},bg:${light_beige},hl:${blue},fg+:${light_beige},bg+:${green},hl+:${blue}"
      "--color info:${yellow},prompt:${yellow},pointer:${light_beige},marker:${light_beige},spinner:${yellow}"
      # Disable the default horizontal line separator between the typing area and the matches
      "--no-separator"
    ];
    # Default command for the CTRL+T key binding
    fileWidgetCommand = "${config.programs.fzf.defaultCommand}";
  };

  programs.zsh.initExtra = ''
    function cd_to_ranger_bookmark_and_projet_directories() {
      local directory
      # Take the ranger bookmarks, format them before adding all directories under ~/projets to the list of directories to be processed by fzf
      directory=$(cat "${config.xdg.configHome}/ranger/bookmarks" | { sed -n "s/.*:\(.*\)$/\1/p"; \ls --directory ~/projets/* } | sort | uniq | fzf)

      cd "$directory" || exit

      zle && zle accept-line
    }

    # Define keybind CTRL+G to call the function
    zle -N cd_to_ranger_bookmark_and_projet_directories
    bindkey '^g' cd_to_ranger_bookmark_and_projet_directories
  '';
}

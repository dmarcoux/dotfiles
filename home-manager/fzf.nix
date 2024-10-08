# User configuration for fzf

{ config, ... }:

{
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
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
      # Disable the default horizontal line separator between the typing area and the matches
      "--no-separator"
    ];
    # Default command for the CTRL+T key binding
    fileWidgetCommand = "${config.programs.fzf.defaultCommand}";
  };

  programs.zsh.initExtra = ''
    function cd_to_lf_g_mappings_and_project_directories() {
      local directory
      # Take the lf g mappings, format them before adding all directories under ~/projets to the list of directories to be processed by fzf
      directory=$(cat ${config.xdg.configHome}/lf/lfrc | { sed -n -e 's|\s*map g.* cd "\?\(.*\)"\?|\1|gp'; \ls --directory ~/projets/* } | sort | uniq | fzf)

      cd "$directory" || echo "$directory doesn't exist."

      zle && zle accept-line
    }

    # Define keybind CTRL+G to call the function
    zle -N cd_to_lf_g_mappings_and_project_directories
    bindkey '^g' cd_to_lf_g_mappings_and_project_directories
  '';
}

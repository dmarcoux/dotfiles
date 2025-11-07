# User configuration for fzf

{ config, ... }:

# To directly use base00, base01, base02, etc...
with config.lib.stylix.colors.withHashtag;

{
  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
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
      # Default colors
      "--color fg:${base03},bg:${base00},hl:${base0D}:bold,fg+:${base00},bg+:${base0B},hl+:${base0D}:bold"
      "--color info:${base0A},prompt:${base0A},pointer:${base00},marker:${base00},spinner:${base0A}"
      # Disable the default horizontal line separator between the typing area and the matches
      "--no-separator"
    ];
    # Default command for the CTRL+T key binding
    fileWidgetCommand = "${config.programs.fzf.defaultCommand}";
  };

  programs.zsh.initContent = ''
    function cd_to_lf_g_mappings_and_project_directories() {
      local directory
      # Take the lf g mappings (except `g,`), format them before adding all directories under $XDG_PROJETS_DIR to the list of directories to be processed by fzf
      directory=$(cat ${config.xdg.configHome}/lf/lfrc | { sed -n -e 's|\s*map g[^,]* cd "\?\(.*\)"\?|\1|gp'; \ls --directory ${config.xdg.userDirs.extraConfig.XDG_PROJETS_DIR}/* } | sort | uniq | fzf)

      cd "$directory" || echo "$directory doesn't exist."

      zle && zle accept-line
    }

    # Define keybind CTRL+G to call the function
    zle -N cd_to_lf_g_mappings_and_project_directories
    bindkey '^g' cd_to_lf_g_mappings_and_project_directories
  '';
}

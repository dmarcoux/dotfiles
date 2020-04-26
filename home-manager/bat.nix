# User configuration for bat

{
  programs.bat = {
    enable = true;
    config = {
      color = "never";
      # TODO: Replace color with this when NixOS 20.09 is released (double-check the name of the theme)
      # theme = "solarized-light";
    };
  };

  programs.zsh.shellAliases = { cat = "bat"; };
}

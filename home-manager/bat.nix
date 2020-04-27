# User configuration for bat

{
  programs.bat = {
    enable = true;
    config = {
      # TODO: Replace theme with solarized light when NixOS 20.09 is released (double-check the name of the theme)
      theme = "ansi-light";
    };
  };

  programs.zsh.shellAliases = { cat = "bat"; };
}

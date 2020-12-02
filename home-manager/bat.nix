# User configuration for bat

{
  programs.bat = {
    enable = true;
    config = {
      theme = "Solarized (light)";
    };
  };

  programs.zsh.shellAliases = { cat = "bat"; };
}

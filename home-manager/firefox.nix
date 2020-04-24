# User configuration for firefox

{ pkgs, ... }:

{
  # Set firefox as the default browser
  home.sessionVariables = { BROWSER = "firefox"; };

  programs.firefox = {
    # Install firefox
    enable = true;
  };
}

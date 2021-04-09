# System configuration for zsh

{ pkgs, ... }:

{

  programs.zsh = {
    # Install zsh
    enable = true;
    # This is set per user with home-manager
    enableGlobalCompInit = false;
    # Remove NixOS default zsh configuration, zsh is configured with home-manager
    promptInit = "";
    setOptions = [];
  };

  # Set zsh as default shell
  users.defaultUserShell = pkgs.zsh;

  environment = {
    # Remove shell aliases set by NixOS' defaults
    shellAliases = {};
    # Include ~/bin/ in $PATH
    homeBinInPath = true;
  };
}

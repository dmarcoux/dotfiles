# System configuration for zsh

{ pkgs, ... }:

{

  # Enable zsh and leave extra configuration to home-manager
  programs.zsh = {
    enable = true;
    # This is set per user
    enableGlobalCompInit = false;
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

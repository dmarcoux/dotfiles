# System configuration for zsh

{ pkgs, ... }:

{
  # Set zsh as default shell
  users.defaultUserShell = pkgs.zsh;

  environment = {
    # Remove shell aliases set by NixOS' defaults
    shellAliases = {};
    # Include ~/bin/ in $PATH
    homeBinInPath = true;
    # Enable completion for system packages
    pathsToLink = [ "/share/zsh" ];
  };
}

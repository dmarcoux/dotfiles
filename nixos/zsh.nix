# Configuration for zsh

{ pkgs, ... }:

{
  # Set zsh as default shell
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  environment = {
    # Remove shell aliases set by NixOS' defaults
    shellAliases = {};
    # Include ~/bin/ in $PATH
    homeBinInPath = true;
  };
}

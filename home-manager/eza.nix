# User configuration for eza

{ pkgs, ... }:

{
  # Install eza
  home.packages = [ pkgs.eza ];

  # Aliases
  programs.zsh.initExtra = ''
    ealias ls="eza --all --group-directories-first --across"
    ealias ll="eza --all --group-directories-first --long"
  '';
}

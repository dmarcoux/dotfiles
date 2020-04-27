# User configuration for exa

{ pkgs, ... }:

{
  # Install exa
  home.packages = [ pkgs.exa ];

  # Aliases
  programs.zsh.initExtra = ''
    ealias ls="exa --all --group-directories-first --across"
    ealias ll="exa --all --group-directories-first --long"
  '';
}

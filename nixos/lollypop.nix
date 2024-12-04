# System configuration for lollypop, a music player

{ pkgs, ... }:

{
  # Install lollypop
  environment.systemPackages = [ pkgs.lollypop ];

  # dconf is needed to be able to store changes in lollypop's settings
  programs.dconf.enable = true;
}

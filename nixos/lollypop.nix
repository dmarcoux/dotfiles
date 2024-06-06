# System configuration for lollypop, a music player

{ pkgs, ... }:

{
  # Install lollypop
  environment.systemPackages = [ pkgs.lollypop ];
}

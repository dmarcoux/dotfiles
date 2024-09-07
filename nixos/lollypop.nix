# System configuration for lollypop, a music player

{ pkgs-unstable, ... }:

{
  # Install lollypop
  # TODO: NixOS 24.11 Go back to default channel, unstable is needed only for this https://github.com/NixOS/nixpkgs/pull/326444
  environment.systemPackages = [ pkgs-unstable.lollypop ];

  # dconf is needed to be able to store changes in lollypop's settings
  programs.dconf.enable = true;
}

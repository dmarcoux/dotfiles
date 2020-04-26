# User configuration with home-manager
# https://rycee.gitlab.io/home-manager/options.html

{ config, pkgs, ... }:

{
  imports = [
    ./bat.nix
    ./firefox.nix
    ./git.nix
    ./gnupg.nix
    ./i3.nix
    ./password-store.nix
    ./redshift.nix
    ./ripgrep.nix
    ./rofi.nix
    ./udiskie.nix
    ./xdg.nix
  ];

  # Don't manage the keyboard configuration with home-manager
  home.keyboard = null;

  # Enable home-manager to start the X session (otherwise graphical services are not started automatically)
  xsession.enable = true;
}

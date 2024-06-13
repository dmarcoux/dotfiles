# System configuration for lollypop, a music player

{ pkgs, ... }:

{
  # Install lollypop
  environment.systemPackages = [ pkgs.lollypop ];

  # dconf is needed to be able to store changes in lollypop's settings
  programs.dconf.enable = true;

  # Gnome keyring is needed to store credentials for the various web services (last.fm, etc...) integrated into lollypop
  services.gnome.gnome-keyring.enable = true;
}

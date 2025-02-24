# System configuration for GNOME apps
# It cannot be done in home-manager: https://github.com/nix-community/home-manager/issues/1454

{ pkgs, lib, ... }:

{
  # dconf is needed to be able to store settings of various GNOME apps
  programs.dconf.enable = true;

  # Launch GNOME Keyring to store security credentials. It's used by many applications like JetBrains IDEs to store database passwords
  services.gnome.gnome-keyring.enable = true;

  # Install Seahorse to view/manage encryption keys and passwords in the GNOME Keyring
  programs.seahorse.enable = true;

  # For GNOME Keyring to unlock by default, but this doesn't work since the X session is managed by home-manager (which creates ~/.xsession)...
  services.xserver.updateDbusEnvironment = true;
  # ... so in this case, we need to run the command below as noted in https://github.com/NixOS/nixpkgs/issues/174099#issuecomment-1201697954
  services.xserver.displayManager.sessionCommands = ''
    ${lib.getBin pkgs.dbus}/bin/dbus-update-activation-environment --systemd --all
  '';
}

# Host-specific configuration for my personal laptop

{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix # Include the results of the hardware scan
    ../../nixos/configuration.nix # System configuration
  ];

  # Use the systemd-boot EFI boot loader
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName = "DM-Laptop-Work";
    networkmanager.enable = true;
  };

  # Enable touchpad support
  services.xserver.libinput.enable = true;
}

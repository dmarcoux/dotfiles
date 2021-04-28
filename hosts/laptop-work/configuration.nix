# Host-specific configuration for my laptop at work

{ config, pkgs, ... }:

{
  imports = [
    ./autorandr.nix
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

  # Enable bluetooth support
  hardware.bluetooth.enable = true;
  # Install blueman, a GUI to manage Bluetooth devices
  services.blueman.enable = true;
}

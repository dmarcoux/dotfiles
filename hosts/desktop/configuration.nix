# Host-specific configuration for my desktop computer

{ config, pkgs, ... }:

{
  imports = [
    ./autorandr.nix
    ./hardware-configuration.nix # Include the results of the hardware scan
    ../../nixos/configuration.nix # System configuration
    # Secrets for work
    # ../../secrets/certificates/work.nix
    # ../../secrets/vpn/work.nix
    # ../../secrets/ssh/work.nix

  ];

  # Use the systemd-boot EFI boot loader
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName = "DM-Desktop";
    networkmanager.enable = true;
  };

  # Enable bluetooth support
  hardware.bluetooth.enable = true;
  # Install blueman, a GUI to manage Bluetooth devices
  services.blueman.enable = true;
}

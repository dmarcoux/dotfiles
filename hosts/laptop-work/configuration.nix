# Host-specific configuration for my laptop at work

{ config, pkgs, ... }:

{
  imports = [
    <nixos-hardware/dell/precision/5530> # From the nixos-hardware channel, its source is https://github.com/NixOS/nixos-hardware
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
  services.xserver.libinput = {
    enable = true;

    touchpad = {
      disableWhileTyping = true;
      # Disables tap-to-click behavior
      tapping = false;
    };
  };

  # Enable bluetooth support
  hardware.bluetooth.enable = true;
  # Install blueman, a GUI to manage Bluetooth devices
  services.blueman.enable = true;

  # Disable Nvidia Quadro graphics card. This improves the battery life.
  hardware.nvidiaOptimus.disable = true;
}

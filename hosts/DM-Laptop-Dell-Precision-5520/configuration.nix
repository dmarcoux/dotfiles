# Host-specific configuration for my Dell Precision 5520 laptop

{ config, pkgs, ... }:

{
  imports = [
    # Declaratively import nixos-hardware to avoid relying on Nix channels
    # Pin nixos-hardware to a revision to have reproducible builds
    "${builtins.fetchGit {
      url = "https://github.com/NixOS/nixos-hardware.git";
      name = "nixos-hardware-26-06-2024";
      rev = "aab67495e34365045f9dfbe58725cc6fa03607b7";
    }}/dell/precision/5530"
    ./autorandr.nix
    ./hardware-configuration.nix # Include the results of the hardware scan
    ./disko-config.nix
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
    # Timeout (in seconds) until loader boots the default menu item (the latest NixOS generation)
    timeout = 20;
  };

  networking = {
    hostName = "DM-Laptop-Dell-Precision-5520";
    networkmanager.enable = true;
  };

  # Enable touchpad support
  services.libinput = {
    enable = true;

    touchpad = {
      disableWhileTyping = true;
      # Disables tap-to-click behavior
      tapping = false;
    };
  };

  hardware.bluetooth = {
    # Enable bluetooth support
    enable = true;
    # Power up the default Bluetooth controller on boot
    powerOnBoot = true;

    settings = {
      General = {
        # For modern headsets, enable A2DP sink
        Enable = "Source,Sink,Media,Socket";
      };
    };
  };
  # Install blueman, a GUI to manage Bluetooth devices
  services.blueman.enable = true;

  # Disable Nvidia Quadro graphics card. This improves the battery life.
  hardware.nvidiaOptimus.disable = true;
}

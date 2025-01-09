# Host-specific configuration for my Dell Precision 3581 laptop

{ config, pkgs, secrets, ... }:

{
  imports = [
    # Declaratively import nixos-hardware to avoid relying on Nix channels
    # Pin nixos-hardware to a revision to have reproducible builds
    "${builtins.fetchGit {
      url = "https://github.com/NixOS/nixos-hardware.git";
      name = "nixos-hardware-26-06-2024";
      rev = "aab67495e34365045f9dfbe58725cc6fa03607b7";
    }}/dell/precision/3541" # Similar to my laptop, but an older generation
    ./autorandr.nix
    ./hardware-configuration.nix # Include the results of the hardware scan
    ./disko-config.nix
    ./nixos.nix
    ./home-manager.nix
    "${secrets}/samba-cifs.nix"
  ];

  # Use the systemd-boot EFI boot loader
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    # Timeout (in seconds) until loader boots the default menu item (the latest NixOS generation)
    timeout = 20;
  };

  networking = {
    hostName = "DM-Laptop-Dell-Precision-3581";
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

  # Enable the Bolt daemon for Thunderbolt devices
  # `boltctl` to list and authorize devices. For every device, it must be authorized with `boltctl enroll --chain UUID_FROM_YOUR_DEVICE`.
  services.hardware.bolt.enable = true;

  # Extra packages only for this host
  environment.systemPackages = with pkgs; [
    # VPN client for Cisco's AnyConnect SSL VPN
    openconnect
    # NetworkManager’s OpenConnect plugin
    networkmanager-openconnect
    # Distributed, highly available, datacenter-aware scheduler
    # TODO: I might need to instead use the service to setup nomad: https://search.nixos.org/options?channel=24.11&from=0&size=50&sort=relevance&type=packages&query=services.nomad
    nomad
    # Samba / CIFS
    samba
  ];
}

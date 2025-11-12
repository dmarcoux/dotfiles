# Host-specific configuration for my desktop computer

{ config, pkgs, pkgs-unstable, ... }:

{
  imports = [
    ./autorandr.nix
    ./hardware-configuration.nix # Include the results of the hardware scan
    ./disko-config.nix
    ./nixos.nix
    ./home-manager.nix
  ];

  # Use the GRUB boot loader to dual-boot Windows and NixOS
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      # # /boot is the mount point of the EFI partition in NixOS (as the installation documentation recommends)
      # efiSysMountPoint = "/boot";
    };

    # Timeout (in seconds) until loader boots the selected boot entry
    timeout = 20;

    grub = {
      enable = true;
      devices = [ "nodev" ];
      efiSupport = true;
      # Detect other systems present on the computer and add a boot entry for each of them
      useOSProber = true;
      # Remember the last accessed boot entry. Useful when selecting one boot entry most of the time
      default = "saved";
    };
  };

  networking = {
    hostName = "DM-Desktop";
    networkmanager.enable = true;
  };

  # Enable bluetooth support
  hardware.bluetooth.enable = true;
  # Install blueman, a GUI to manage Bluetooth devices
  services.blueman.enable = true;

  hardware.nvidia = {
    # "production" driver aims to improve stability.
    package = config.boot.kernelPackages.nvidiaPackages.production;
    # Fix suspend/resume issues due to NVIDIA GPU.
    powerManagement.enable = true;
    powerManagement.finegrained = false;
  };

  # System clock might be incorrect after booting Windows and going back to the NixOS
  # This sets RTC time standard to localtime, compatible with Windows in its default configuration
  time.hardwareClockInLocalTime = true;

  # Extra packages only for this host
  environment.systemPackages = with pkgs; [
    # Voice, video, and text chat
    pkgs-unstable.discord
    # CLI for https://exercism.org - Solve coding exercises and get mentored to gain true fluency in your chosen programming languages
    pkgs-unstable.exercism
    # Music tagger to fix music files with wrong metadata tags
    picard
    # Chat for various communities
    slack
  ];
}

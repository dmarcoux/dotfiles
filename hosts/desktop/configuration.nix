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

  # Use the GRUB boot loader to dual-boot Windows and NixOS
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      # # /boot is the mount point of the EFI partition in NixOS (as the installation documentation recommends)
      # efiSysMountPoint = "/boot";
    };

    grub = {
      enable = true;
      devices = [ "nodev" ];
      efiSupport = true;
      # Detect other systems present on the computer and add a menu entry for each of them
      useOSProber = true;
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

  # System clock might be incorrect after booting Windows and going back to the NixOS
  # This sets RTC time standard to localtime, compatible with Windows in its default configuration
  time.hardwareClockInLocalTime = true;
}

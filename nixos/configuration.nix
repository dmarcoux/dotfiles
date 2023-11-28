# System configuration which applies to all users
# https://nixos.org/nixos/manual/options.html

{ config, pkgs, options, ... }:

{
  # Pull nixos-unstable channel to allow installation of the latest available packages if needed
  # It's pinned to a revision to have reproducible builds
  # Use `pkgs.unstable.package_name` to install a package from the unstable channel
  nixpkgs.config = {
    packageOverrides = pkgs: {
      unstable = import (builtins.fetchTarball {
        # Descriptive name to make the store path easier to identify
        name = "nixos-unstable-25-11-2023";
        # Find the hash of the latest commit for nixos-unstable with
        # git ls-remote https://github.com/nixos/nixpkgs nixos-unstable
        url = "https://github.com/nixos/nixpkgs/archive/19cbff58383a4ae384dea4d1d0c823d72b49d614.tar.gz";
        # Obtained using `nix-prefetch-url --unpack <url>`
        sha256 = "0dzvnjccsnc2661yks0xypj2px335k6abysm335z1yh3qfi3rd6a";
      }) {
        config = config.nixpkgs.config;
      };
    };
  };

  imports = [
    (import ./home-manager.nix { pkgs = pkgs; config = config; nixos_options = options; })
    ./chromium.nix
    ./docker.nix
    ./evince.nix
    ./i3.nix
    ./keyboard.nix
    ./locales.nix
    ./lollypop.nix
    ./nixFlakes.nix
    ./packages.nix
    ./podman.nix
    ./printing.nix
    ./redshift.nix
    ./syncthing.nix
    ./udiskie.nix
    ./unclutter.nix
    ./vscode.nix
    ./yubikey.nix
    ./zsh.nix
  ];

  # Allow installation of unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable all experimental features of the `nix` command without having to always do `nix --extra-experimental-features nix-command some_experimental_command`
  nix.settings.experimental-features = [ "nix-command" ];

  # Install documentation targeted at developers
  documentation.dev.enable = true;
  environment.systemPackages = [ pkgs.man-pages ];

  # If needed, pin Linux kernel to latest LTS version which is bootable.
  # When commented out, keeping this as an example.
  # boot.kernelPackages = pkgs.linuxPackagesFor (pkgs.linux_6_1.override {
  #   argsOverride = rec {
  #     src = pkgs.fetchurl {
  #           url = "mirror://kernel/linux/kernel/v6.x/linux-${version}.tar.xz";
  #           sha256 = "vSNDOW592tiXTzaJpaBn7JMfSt55PnKxBwqFzRnx8ZI=";
  #     };
  #     version = "6.1.45";
  #     modDirVersion = "6.1.45";
  #     };
  # });

  # Delete all files in /tmp during boot
  boot.tmp.cleanOnBoot = true;

  # Enable a basic set of fonts providing several font styles and families and reasonable coverage of Unicode
  fonts.enableDefaultFonts = true;

  time.timeZone = "Europe/Berlin";

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  services = {
    xserver = {
      # Enable the X11 windowing system
      enable = true;

      # Symlink the X server configuration under /etc/X11/xorg.conf
      # Without this, some commands fail: https://github.com/NixOS/nixpkgs/issues/19629#issuecomment-418238130
      exportConfiguration = true;

      # Enable minimal desktop/display manager setup to have a login screen
      # home-manager will take over after login in
      desktopManager.xterm.enable = true;
      displayManager.lightdm.enable = true;

      # Disable screensaver and display power manager signaling (DPMS)
      displayManager.sessionCommands = ''
        ${pkgs.xorg.xset}/bin/xset s off -dpms
      '';
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’
  users.users.dany = {
    isNormalUser = true;
    description = "Dany Marcoux";
    extraGroups = [
      "wheel" # Enable ‘sudo’ for the user
      "networkmanager" # Enable configuration of the network with NetworkManager
    ];
  };

  # `sudo` asks for the root password
  security.sudo.extraConfig = "Defaults rootpw";

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should
  system.stateVersion = "23.05";

  # TODO: https://github.com/NixOS/nixpkgs/issues/180175
  systemd.services.NetworkManager-wait-online.enable = false;
}

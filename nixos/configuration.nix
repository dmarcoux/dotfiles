# System configuration which applies to all users
# https://nixos.org/nixos/manual/options.html

{ config, pkgs, options, ... }:

let
  # Setup nixos-unstable channel to allow installation of the latest available packages if needed
  # This is useful when needing the newest version of a package which isn't available in the current stable channel
  # Prerequisites:
  #   sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos-unstable
  #   sudo nix-channel --update
  # Then install the latest version of a package with `unstable.the_package_name`
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in
{
  imports = [
    # Pass packages from the stable and unstable channels
    (import ./docker.nix { pkgs = pkgs; unstable = unstable; })
    (import ./packages.nix { pkgs = pkgs; unstable = unstable; })
    (import ./home-manager.nix { pkgs = pkgs; config = config; unstable = unstable; nixos_options = options; })
    ../secrets/certificates/work.nix
    ../secrets/vpn/work.nix
    ./chromium.nix
    ./evince.nix
    ./i3.nix
    ./keyboard.nix
    ./locales.nix
    ./lollypop.nix
    ./nixFlakes.nix
    ./podman.nix
    ./printing.nix
    ./redshift.nix
    ./udiskie.nix
    ./unclutter.nix
    ./virtualbox.nix
    ./vscode.nix
    ./wacom.nix
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

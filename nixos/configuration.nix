# System configuration which applies to all users
# https://nixos.org/nixos/manual/options.html

{ config, pkgs, ... }:

{
  imports = [
    ../secrets/vpn/work.nix
    ./chromium.nix
    ./docker.nix
    ./home-manager.nix
    ./i3.nix
    ./keyboard.nix
    ./locales.nix
    ./open-build-service.nix
    ./packages.nix
    ./redshift.nix
    ./unclutter.nix
    ./vim.nix
    ./zsh.nix
  ];

  # Allow installation of unfree packages
  nixpkgs.config.allowUnfree = true;

  # Install documentation targeted at developers
  documentation.dev.enable = true;
  environment.systemPackages = [ pkgs.manpages ];

  # Enable a basic set of fonts providing several font styles and families and reasonable coverage of Unicode
  fonts.enableDefaultFonts = true;

  time.timeZone = "Europe/Berlin";

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  services = {
    # Enable CUPS to print documents.
    printing.enable = true;

    xserver = {
      # Enable the X11 windowing system
      enable = true;

      # Enable minimal desktop/display manager setup to have a login screen
      # home-manager will take over after login in
      desktopManager.xterm.enable = true;
      displayManager.lightdm.enable = true;
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

  # TODO: Use this with hashedPassword
  # Prevent adding users/groups with `useradd` and `groupadd`
  # users.mutableUsers = false;

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should
  system.stateVersion = "19.09";
}

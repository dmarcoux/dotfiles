# System configuration which applies to all users
# https://nixos.org/nixos/manual/options.html

{ config, pkgs, ... }:

{
  imports = [
    <home-manager/nixos> # from home-manager channel
    # TODO: Split between system and user configuration
    ./chromium.nix
    ./docker.nix
    ./git.nix
    ./open-build-service.nix
    ./packages.nix
    ./ranger.nix
    ./redshift.nix
    ./vim.nix
    ./vscode.nix
    ./xfce-with-i3.nix
    ./zsh.nix
  ];

  # Allow installation of unfree packages
  nixpkgs.config.allowUnfree = true;

  # Configure the console keymap from the xserver keyboard settings
  console.useXkbConfig = true;

  # Select internationalisation properties
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LANGUAGE = "en_US.UTF-8";
      LC_COLLATE = "en_US.UTF-8";
      LC_CTYPE = "en_US.UTF-8";
      LC_TIME = "fr_CA.UTF-8";
      LESSCHARSET = "utf-8";
    };
  };

  # Enable a basic set of fonts providing several font styles and families and reasonable coverage of Unicode
  fonts.enableDefaultFonts = true;

  time.timeZone = "Europe/Berlin";

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  services = {
    # Enable CUPS to print documents.
    printing.enable = true;

    unclutter = {
      # Hide mouse cursor when inactive
      enable = true;
      # Number of seconds before the cursor is marked as inactive
      timeout = 10;
    };

    xserver = {
      # Enable the X11 windowing system
      enable = true;

      # Set keyboard layout to Canadian Multilingual
      layout = "ca";
      xkbVariant = "multi";
      # AltGr + e for €, Swap Left Control and Caps Lock
      xkbOptions = "eurosign:e,ctrl:swapcaps";
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

  # User configuration with home-manager
  home-manager.users.dany = import ../home-manager/home.nix ;
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

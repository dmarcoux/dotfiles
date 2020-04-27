# System configuration which applies to all users
# https://nixos.org/nixos/manual/options.html

{ config, pkgs, ... }:

{
  imports = [
    <home-manager/nixos> # from home-manager channel
    ./chromium.nix
    ./docker.nix
    ./i3.nix
    ./open-build-service.nix
    ./packages.nix # TODO: Split packages between system and user configuration
    ./ranger.nix
    ./redshift.nix
    ./vim.nix
    ./vscode.nix # TODO: Split between system and user configuration
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

      # Enable minimal desktop/display manager setup to have a login screen
      # home-manager will take over after login in
      desktopManager.xterm.enable = true;
      displayManager.lightdm.enable = true;

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

  home-manager = {
    # User configuration with home-manager
    users.dany = import ../home-manager/home.nix;
    # Whenever home-manager installs packages, install them as system packages (so what NixOS does)
    useUserPackages = true;
    # Have home-manager rely on the global `pkgs` configured via the system options `nixpkgs`
    useGlobalPkgs = true;
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

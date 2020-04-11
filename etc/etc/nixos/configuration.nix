# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’)

{ config, pkgs, ... }:

{
  imports = [ 
    /etc/nixos/hardware-configuration.nix # Include the results of the hardware scan
  ];

  # Allow installation of unfree packages
  nixpkgs.config.allowUnfree = true;

  # Use the systemd-boot EFI boot loader
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName = "DM-Laptop";
    networkmanager.enable = true;

    # The global useDHCP flag is deprecated, therefore explicitly set to false here.
    # Per-interface useDHCP will be mandatory in the future, so this generated config
    # replicates the default behaviour
    useDHCP = false;
    interfaces = {
      enp2s0.useDHCP = true;
      wlp3s0.useDHCP = true;
    };
  }; 

  # Select internationalisation properties
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleUseXkbConfig = true; # Configure the console keymap from the xserver keyboard settings
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = { LC_TIME = "fr_CA.UTF-8"; };
  };

  # Enable a basic set of fonts providing several font styles and families and reasonable coverage of Unicode
  fonts.enableDefaultFonts = true;

  time.timeZone = "Europe/Berlin";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim ranger ripgrep fzf firefox fd gitMinimal bat flameshot rofi
    pass pass-otp stow exa vscode
  ];

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable location with geoclue2 for redshift
  location.provider = "geoclue2";

  services = {
    # Enable CUPS to print documents.
    printing.enable = true;

    # Use redshift to adapt screen's color temperature depending on the time of day
    redshift = {
      enable = true;
      temperature = {
        day = 5500;
        night = 3500;
      };
    };

    xserver = {
      # Enable the X11 windowing system
      enable = true;

      # Set keyboard layout to Canadian Multilingual
      layout = "ca";
      xkbVariant = "multi";
      xkbOptions = "eurosign:e";

      # Enable touchpad support
      libinput.enable = true;

      # Enable the KDE Desktop Environment
      displayManager.sddm.enable = true;
      desktopManager.plasma5.enable = true;
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

  # Set zsh as default shell
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # Use GnuPG agent with SSH support
  programs.gnupg = {
    agent = {
      enable = true;
      enableSSHSupport = true;
    };
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

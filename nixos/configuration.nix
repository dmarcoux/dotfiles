# System configuration which applies to all users
# https://nixos.org/nixos/manual/options.html

{ config, pkgs, options, ... }:

{
  # Nix will conform to the XDG Base Directory Specification for files in $HOME
  nix.settings.use-xdg-base-directories = true;

  nix.settings.experimental-features = [
    # Enable all experimental features of the `nix` command without having to always do `nix --extra-experimental-features nix-command some_experimental_command`
    "nix-command"
    # Enable flakes (https://nixos.wiki/wiki/Flakes)
    "flakes"
  ];

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

  # Enable Plymouth boot splash screen
  # TODO: Customize this with `boot.plymouth.theme`, it could be fun :D. Search for inspiration: https://github.com/search?q=language%3Anix+plymouth&type=code
  boot.plymouth.enable = true;
  # With this, Plymouth shows the passphrase prompt to unlock LUKS-encrypted disks. Otherwise, Plymouth would start after entering the LUKS passphrase.
  # See https://github.com/NixOS/nixpkgs/issues/26722 for details.
  boot.initrd.systemd.enable = true;
  # Show a blank screen before plymouth takes over.
  # Without `quiet` and `splash`, the details fallback plymouth theme is used and shows systemd messages.
  boot.kernelParams = [ "quiet" "splash" ];

  # Enable a basic set of fonts providing several font styles and families and reasonable coverage of Unicode
  fonts.enableDefaultPackages = true;
  # Install Nerd Fonts' version of DejaVu Sans Mono. Nerd Fonts are patched and ready-to-use programming fonts: https://www.nerdfonts.com/
  fonts.packages = [ pkgs.nerd-fonts.dejavu-sans-mono ];

  time.timeZone = "Europe/Berlin";

  services = {
    # Handle interfacing with audio/video devices
    pipewire = {
      enable = true;
      # Enable ALSA support
      alsa.enable = true;
      # Enable PulseAudio server emulation
      pulse.enable = true;
      # TODO: Extra audio codecs, see this example:
      # https://wiki.nixos.org/wiki/PipeWire
      # https://github.com/TLATER/dotfiles/blob/a31d74856710936b398318062f0af6616d994eba/nixos-config/default.nix#L189
    };

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

  # Recommended for PipeWire
  security.rtkit.enable = true;

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
  system.stateVersion = "25.05";

  # TODO: https://github.com/NixOS/nixpkgs/issues/180175
  systemd.services.NetworkManager-wait-online.enable = false;
}

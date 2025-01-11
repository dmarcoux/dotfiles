# NixOS configuration for my Dell Precision 3581 laptop

{ pkgs, ... }:

{
  imports = [
    # NixOS base configuration
    ../../nixos/configuration.nix
    # Everything else... this list is adapted to this host
    ../../nixos/1password.nix
    ../../nixos/chromium.nix
    ../../nixos/docker.nix
    ../../nixos/evince.nix
    ../../nixos/gnome-keyring.nix
    ../../nixos/i3.nix
    ../../nixos/keyboards.nix
    ../../nixos/locales.nix
    ../../nixos/networking.nix
    ../../nixos/packages.nix
    ../../nixos/podman.nix
    ../../nixos/polkit.nix
    ../../nixos/printing.nix
    ../../nixos/redshift.nix
    ../../nixos/stylix.nix
    ../../nixos/udiskie.nix
    ../../nixos/unclutter.nix
    ../../nixos/yubikey.nix
    ../../nixos/zsh.nix
  ];

  # TODO: Temporary for now while I experiment with KDE
  # Enable minimal desktop/display manager setup to have a login screen
  # home-manager will take over after login in
  services.xserver = {
    desktopManager.xterm.enable = true;
    displayManager.lightdm.enable = true;

    # Disable screensaver and display power manager signaling (DPMS)
    displayManager.sessionCommands = ''
      ${pkgs.xorg.xset}/bin/xset s off -dpms
    '';

    xkb = {
      # Set multiple keyboard layouts (This is useful when pair-programming with colleagues which are used to another layout)
      # - Canadian Multilingual: https://kbdlayout.info/kbdcan
      # - German: https://kbdlayout.info/kbdgr
      # - US: https://kbdlayout.info/kbdus
      layout = "ca(multix),de,us";
      # AltGr + Space produces a normal space instead of a non-breakable space
      # Alt + Space switches to the next keyboard layout
      options = "nbsp:none,grp:alt_space_toggle";
    };
  };
}

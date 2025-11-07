# NixOS configuration for my Dell Precision 3581 laptop

{
  imports = [
    # NixOS base configuration
    ../../nixos/configuration.nix
    ../../nixos/fhs-compat.nix
    # Everything else... this list is adapted to this host
    ../../nixos/1password.nix
    ../../nixos/chromium.nix
    ../../nixos/docker.nix
    ../../nixos/evince.nix
    ../../nixos/gnome.nix
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
}

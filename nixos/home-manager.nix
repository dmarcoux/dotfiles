# Setup home-manager

{
  imports = [
    <home-manager/nixos> # from home-manager channel
  ];

  home-manager = {
    # User configuration with home-manager
    users.dany = import ../home-manager/home.nix;
    # Whenever home-manager installs packages, install them as system packages (so what NixOS does)
    useUserPackages = true;
    # Have home-manager rely on the global `pkgs` configured via the system options `nixpkgs`
    useGlobalPkgs = true;
  };
}

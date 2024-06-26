# Setup home-manager

{ pkgs, config, nixos_options, ... }:

{
  imports = [
    # Declaratively import home-manager to avoid relying on Nix channels
    # For updates, simply replace the version number, like 24.05, by the new one
    (import "${builtins.fetchTarball https://github.com/nix-community/home-manager/archive/release-24.05.tar.gz}/nixos")
  ];

  home-manager = {
    # User configuration with home-manager
    users.dany = (import ../home-manager/home.nix { pkgs = pkgs; config = config; nixos_options = nixos_options; });
    # By default, packages will be installed to `~/.nix-profile`
    # With useUserPackages set to `true`, packages will be installed to `/etc/profiles/per-user/$USER` instead
    useUserPackages = true;
    # Have home-manager rely on the global `pkgs` configured via the system options `nixpkgs`
    useGlobalPkgs = true;
  };
}

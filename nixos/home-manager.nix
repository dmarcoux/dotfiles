# Setup home-manager

{ pkgs, config, nixos_options, ... }:

{
  imports = [
    <home-manager/nixos> # from home-manager channel
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

{
  description = "NixOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";

    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/release-24.05";
    # Ensure that nixpkgs and home-manager stay in sync
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ nixpkgs, nixpkgs-unstable, home-manager, ... }:
  let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;

      # Allow installation of unfree packages
      config.allowUnfree = true;
    };

    pkgs-unstable = import nixpkgs-unstable {
      inherit system;

      # Allow installation of unfree packages
      config.allowUnfree = true;
    };
  in
  {
    nixosConfigurations = {
      DM-Laptop = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit system;

          pkgs = pkgs;
          pkgs-unstable = pkgs-unstable;
        };

        modules = [
          ./hosts/laptop/configuration.nix
          home-manager.nixosModules.home-manager
          {
            # Have home-manager rely on the global `pkgs` configured via the system options `nixpkgs`
            home-manager.useGlobalPkgs = true;
            # By default, packages will be installed to `~/.nix-profile`
            # With useUserPackages set to `true`, packages will be installed to `/etc/profiles/per-user/$USER` instead
            home-manager.useUserPackages = true;
            home-manager.users.dany = import ./home-manager/home.nix;

            home-manager.extraSpecialArgs = {
              pkgs-unstable = pkgs-unstable;
            };
          }
        ];
      };

      # TODO: Do the same for the desktop host
      # DM-Desktop = nixpkgs.lib.nixosSystem {
      #   (...)
      #
      #   modules = [
      #     ./hosts/desktop/configuration.nix
      #   ];
      # };
    };
  };
}

{
  description = "NixOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";

    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      # Ensure that nixpkgs and home-manager stay in sync
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      # Follow the stable NixOS release
      url = "github:danth/stylix/release-24.05";
      # Use nixpkgs
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      # Follow the master/main branch
      url = "github:nix-community/nixvim";
      # Use nixpkgs-unstable
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = inputs@{ nixpkgs, nixpkgs-unstable, home-manager, stylix, ... }:
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
      DM-Laptop-Dell-Precision-5520 = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit system;

          pkgs = pkgs;
          pkgs-unstable = pkgs-unstable;
        };

        modules = [
          ./hosts/DM-Laptop-Dell-Precision-5520/configuration.nix
          home-manager.nixosModules.home-manager
          {
            # Have home-manager rely on the global `pkgs` configured via the system options `nixpkgs`
            home-manager.useGlobalPkgs = true;
            # By default, packages will be installed to `~/.nix-profile`
            # With useUserPackages set to `true`, packages will be installed to `/etc/profiles/per-user/$USER` instead
            home-manager.useUserPackages = true;
            home-manager.users.dany.imports = [
              (import ./home-manager/home.nix)
              inputs.nixvim.homeManagerModules.nixvim
            ];

            home-manager.extraSpecialArgs = {
              pkgs-unstable = pkgs-unstable;
            };
          }
          stylix.nixosModules.stylix
        ];
      };

      DM-Desktop = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit system;

          pkgs = pkgs;
          pkgs-unstable = pkgs-unstable;
        };

        modules = [
          ./hosts/DM-Desktop/configuration.nix
          home-manager.nixosModules.home-manager
          {
            # Have home-manager rely on the global `pkgs` configured via the system options `nixpkgs`
            home-manager.useGlobalPkgs = true;
            # By default, packages will be installed to `~/.nix-profile`
            # With useUserPackages set to `true`, packages will be installed to `/etc/profiles/per-user/$USER` instead
            home-manager.useUserPackages = true;
            home-manager.users.dany.imports = [
              (import ./home-manager/home.nix)
              inputs.nixvim.homeManagerModules.nixvim
            ];

            home-manager.extraSpecialArgs = {
              pkgs-unstable = pkgs-unstable;
            };
          }
          stylix.nixosModules.stylix
        ];
      };
    };
  };
}

{
  description = "NixOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";

    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # In case I need packages from staging / staging-next,
    # uncomment the line(s) below and pull packages with them just like with nixpkgs-unstable
    # nixpkgs-staging.url = "github:nixos/nixpkgs/staging";
    # nixpkgs-staging-next.url = "github:nixos/nixpkgs/staging-next";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      # Ensure that nixpkgs and home-manager stay in sync
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      # Follow the stable NixOS release
      url = "github:danth/stylix/release-24.11";
      # Use nixpkgs
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      # Follow the master/main branch
      url = "github:nix-community/nixvim";
      # Use nixpkgs-unstable
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    disko = {
      url = "github:nix-community/disko";
      # Ensure that nixpkgs and disko stay in sync
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # For command-not-found to work, it needs a SQLite database which is only available via NixOS channels.
    # This is the solution for Nix flakes.
    flake-programs-sqlite = {
      url = "github:wamserma/flake-programs-sqlite";
      # Ensure that nixpkgs and flake-programs-sqlite stay in sync
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ nixpkgs, nixpkgs-unstable, home-manager, stylix, disko, flake-programs-sqlite, ... }:
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

    common_modules = [
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
      flake-programs-sqlite.nixosModules.programs-sqlite
    ];
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
          disko.nixosModules.disko # TODO: Move to common_modules once all hosts are using disko
        ] ++ common_modules;
      };

      DM-Desktop = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit system;

          pkgs = pkgs;
          pkgs-unstable = pkgs-unstable;
        };

        modules = [
          ./hosts/DM-Desktop/configuration.nix
        ] ++ common_modules;
      };
    };
  };
}

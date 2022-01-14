# System configuration for Steam

{ pkgs, ... }:

{
  # Install and configure Steam
  programs.steam.enable = true;

  # Add missing dependencies for certain games
  nixpkgs.config.packageOverrides = pkgs: {
    steam = pkgs.steam.override {
      extraPkgs = pkgs: with pkgs; [
        # Unicode and Globalization support for games (Stardew Valley and perhaps other games developed with .NET)
        icu
      ];
    };
  };
}

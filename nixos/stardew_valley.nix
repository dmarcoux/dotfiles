# System configuration for Stardew Valley installed on Steam

{ pkgs, ... }:

{
  # Add missing Steam dependencies for Stardew Valley
  nixpkgs.config.packageOverrides = pkgs: {
    steam = pkgs.steam.override {
      extraPkgs = pkgs: with pkgs; [
        # Unicode and Globalization support
        icu
      ];
    };
  };

  # To develop Stardew Valley mods (as explained on https://stardewvalleywiki.com/Modding:Modder_Guide/Get_Started#Requirements)
  environment.systemPackages = [ pkgs.dotnet-sdk_5 ];
}

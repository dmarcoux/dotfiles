# User configuration for xcape

{ pkgs, ... }:

{
  # Install xcape
  home.packages = [ pkgs.xcape ];

  # Caps Lock acts as Left Control when pressed and held (set with NixOS' services.xserver.xkbOptions)
  # Caps Lock acts as Escape when pressed and quickly released (set with xcape)
  services.xcape = {
    enable = true;
    mapExpression = { Control_L = "Escape"; };
  };
}

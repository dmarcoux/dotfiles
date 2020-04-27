# User configuration for cbatticon

{ pkgs, ... }:

{
  # Install cbatticon
  home.packages = [ pkgs.cbatticon ];

  # Configure cbatticon
  services.cbatticon = {
    enable = true;
    iconType = "standard";
    updateIntervalSeconds = 5;
  };
}

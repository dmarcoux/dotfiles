# User configuration for cbatticon

{ pkgs, ... }:

{
  # Install and configure cbatticon
  services.cbatticon = {
    enable = true;
    iconType = "standard";
    updateIntervalSeconds = 5;
  };
}

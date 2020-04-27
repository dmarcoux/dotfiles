# User configuration for pasystray

{ pkgs, ... }:

{
  # Install pasystray
  home.packages = [ pkgs.pasystray ];

  # Start pasystray
  services.pasystray.enable = true;
}

# User configuration for rofi

# TODO: Remove when rofi is configured with home-manager
{ pkgs, ... }:

{
  home.packages = [ pkgs.rofi ];
  # TODO: Configure rofi with home-manager
  # programs.rofi.*
}

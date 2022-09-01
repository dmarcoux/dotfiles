# User configuration for playerctl

{ pkgs, ... }:

{
  home.packages = with pkgs; [ playerctl ];

  services.playerctld = {
    enable = true;
  };
}

# Configuration for chromium

{ pkgs, ... }:

{
  # Install chromium
  environment.systemPackages = [ pkgs.chromium ];

  # Enable chromium policies
  programs.chromium.enable = true;
}

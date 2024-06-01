# System configuration for chromium

{ pkgs, ... }:

{
  # Install chromium with WideVine to play DRM-protected content
  environment.systemPackages = [ (pkgs.chromium.override { enableWideVine = true; }) ];

  # Enable chromium policies
  programs.chromium.enable = true;
}

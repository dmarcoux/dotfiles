# System configuration for chromium

{ pkgs, ... }:

{
  # Set Chromium as the default browser
  environment.sessionVariables = { BROWSER = "chromium"; };

  # Install chromium with WideVine to play DRM-protected content
  environment.systemPackages = [ (pkgs.chromium.override { enableWideVine = true; }) ];

  # Enable chromium policies
  programs.chromium.enable = true;
}

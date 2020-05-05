# System configuration for i3

{ pkgs, ... }:

{
  # Replace i3lock as the default screen locker
  programs.slock.enable = true;

  # Enable clipmenu, the clipboard management daemon
  services.clipmenu.enable = true;

  # Add font-awesome to fonts for icons in workspace names
  fonts.fonts = with pkgs; [ font-awesome-ttf ];

  services.autorandr = {
    # Handle hotplug and sleep events for monitors with autorandr
    enable = true;
    # If no monitor layout can be detected, fallback to stacking all connected
    # outputs vertically at their largest resolution
    defaultTarget = "vertical";
  };
}

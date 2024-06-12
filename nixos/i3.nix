# System configuration for i3

{ pkgs, ... }:

{
  # Replace i3lock as the default screen locker
  programs.slock.enable = true;

  services.autorandr = {
    # Handle hotplug and sleep events for monitors with autorandr
    enable = true;
  };
}

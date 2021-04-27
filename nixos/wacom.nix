# System configuration for Wacom devices

{ pkgs, ... }:

{
  # Install and setup drivers for Wacom devices
  services.xserver.wacom.enable = true;

  # Install GUI for the Wacom Linux Drivers and extends it with profile support to handle different button / pen layouts per profile
  environment.systemPackages = [ pkgs.wacomtablet ];
}

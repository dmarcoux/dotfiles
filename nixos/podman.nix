# System configuration for podman

{ pkgs, ... }:

{
  # Install podman
  virtualisation.podman.enable = true;

  # Install podman-compose
  environment.systemPackages = [ pkgs.podman-compose ];
}

# System configuration for docker

{ pkgs, pkgs-unstable, ... }:

{
  virtualisation.docker = {
    # Enable docker on boot
    enable = true;
    # Install docker (from unstable to get the latest version)
    package = pkgs-unstable.docker;
  };

  # Allow user to interact with the docker daemon
  users.users.dany.extraGroups = [ "docker" ];
}

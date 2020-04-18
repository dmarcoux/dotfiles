# Configuration for docker

{ pkgs, ... }:

{
  # Enable docker
  virtualisation.docker.enable = true;

  # Allow user to interact with the docker daemon
  users.users.dany.extraGroups = [ "docker" ];
}

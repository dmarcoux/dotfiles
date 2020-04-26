# System configuration for docker

{ pkgs, ... }:

{
  # Install docker and enable it on boot (it's the default)
  virtualisation.docker.enable = true;

  # Install docker-compose
  environment.systemPackages = [ pkgs.docker-compose ];

  # Allow user to interact with the docker daemon
  users.users.dany.extraGroups = [ "docker" ];
}

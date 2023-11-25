# System configuration for docker

{ pkgs, ... }:

{
  virtualisation.docker = {
    # Enable docker on boot
    enable = true;
    # Install docker (from unstable to get the latest version)
    package = pkgs.unstable.docker_20_10;
  };

  # Install docker-compose
  environment.systemPackages = [ pkgs.docker-compose ];

  # Allow user to interact with the docker daemon
  users.users.dany.extraGroups = [ "docker" ];
}

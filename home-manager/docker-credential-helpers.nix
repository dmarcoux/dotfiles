# User configuration for docker-credential-helpers

{ pkgs, ... }:

{
  # Install docker-credential-helpers
  home.packages = [ pkgs.docker-credential-helpers ];

  # Setup docker-credential-helpers
  home.file.".docker/config.json".text = ''
  {
    "credsStore": "pass"
  }
  '';
}

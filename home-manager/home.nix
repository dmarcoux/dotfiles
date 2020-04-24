# User configuration with home-manager
# https://rycee.gitlab.io/home-manager/options.html

{ config, pkgs, ... }:

{
  imports = [
    ./gnupg.nix
    ./password-store.nix
    ./redshift.nix
  ];
}

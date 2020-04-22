# System configuration for redshift

{ pkgs, ... }:

{
  # Enable location with geoclue2
  location.provider = "geoclue2";
}

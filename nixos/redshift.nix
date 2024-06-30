# System configuration for redshift

{ pkgs, ... }:

{
  # Without this package, redshift-gtk doesn't have an icon.
  environment.systemPackages = [ pkgs.hicolor-icon-theme ];

  # Start GeoClue2 daemon
  services.geoclue2.enable = true;

  # Enable location with GeoClue2
  services.geoclue2.appConfig.redshift = {
    isAllowed = true;
    isSystem = false;
  };
  location.provider = "geoclue2";
}

# System configuration for redshift

{
  # Start GeoClue2 daemon
  services.geoclue2.enable = true;

  # Enable location with GeoClue2
  location.provider = "geoclue2";
}

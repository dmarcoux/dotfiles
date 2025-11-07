# User configuration for redshift

{ pkgs, options, ... }:

{
  # Install redshift
  home.packages = [ options.services.redshift.package.value ];

  # Use redshift to adapt screen's color temperature depending on the time of day
  services.redshift = {
    enable = true;

    # Use GeoClue2 as location provider
    provider = "geoclue2";
    # Freiburg im Breisgau
    latitude = 47.9990;
    longitude = 7.8421;

    # Colour temperature to use at day/night, between 1000 and 25000 K
    temperature = {
      day = 5500;
      night = 3500;
    };

    # Start the redshift-gtk tray applet
    tray = true;
  };
}

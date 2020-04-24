# User configuration for redshift

{ pkgs, ... }:

{
  # Install redshift
  home.packages = [ pkgs.redshift ];

  # Use redshift to adapt screen's color temperature depending on the time of day
  services.redshift = {
    enable = true;

    # Use geoclue2 as location provider
    provider = "geoclue2";

    # Colour temperature to use at day/night, between 1000 and 25000 K
    temperature = {
      day = 5500;
      night = 3500;
    };

    # Start the redshift-gtk tray applet
    tray = true;
  };
}

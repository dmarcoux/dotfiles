# Configuration for redshift
{
  # Enable location with geoclue2
  location.provider = "geoclue2";

  # Use redshift to adapt screen's color temperature depending on the time of day
  services.redshift = {
    enable = true;

    temperature = {
      day = 5500;
      night = 3500;
    };
  };
}

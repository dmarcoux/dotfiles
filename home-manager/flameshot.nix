# User configuration for flameshot

{ pkgs, ... }:

{
  # Install flameshot
  home.packages = [ pkgs.flameshot ];

  # Start flameshot
  services.flameshot.enable = true;

  # Configure flameshot
  xdg.configFile."Dharkael/flameshot.ini".text = ''
    [General]
    disabledTrayIcon=false
    drawColor=#ff0000
    drawThickness=0
  '';

  # TODO: 21.11 - Use this instead of code above with manual configuration
  # services.flameshot = {
  #   # Start flameshot
  #   enable = true;
  #
  #   # Configure flameshot
  #   settings = {
  #     General = {
  #       disabledTrayIcon = false;
  #       drawColor = "#ff0000";
  #       drawThickness = 0;
  #     };
  #   };
  # };
}

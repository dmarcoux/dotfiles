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
}

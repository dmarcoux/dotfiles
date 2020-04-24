# User configuration for udiskie

{ pkgs, ... }:

{
  # Install udiskie
  home.packages = [ pkgs.udiskie ];

  services.udiskie = {
    enable = true;
    # Always display the tray icon
    tray = "always";
  };
}

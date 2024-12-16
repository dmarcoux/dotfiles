# User configuration for flameshot

{ pkgs, config, ... }:

{
  # Install flameshot
  home.packages = [ pkgs.flameshot ];

  services.flameshot = {
    # Start flameshot
    enable = true;

    # Configure flameshot
    settings = {
      General = {
        disabledTrayIcon = false;
        drawColor = "#ff0000";
        drawThickness = 1;
        saveAsFileExtension = "png";
        savePath = "${config.xdg.userDirs.pictures}";
        savePathFixed = "false";
        showStartupLaunchMessage = "false";
      };
    };
  };
}

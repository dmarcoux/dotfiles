# User configuration for flameshot

{ pkgs, ... }:

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
        savePath = "/home/dany/pictures";
        savePathFixed = "false";
        setSaveAsFileExtension = "Portable Network Graphic file (PNG) (*.png)";
        showStartupLaunchMessage = "false";
      };
    };
  };
}

# User configuration for autorandr

{
  # If no monitor layout can be detected, fallback to the laptop profile (it's defined below)
  services.autorandr.defaultTarget = "desktop";

  # Find available displays with xrandr
  home-manager.users.dany.programs.autorandr = {
    profiles = {
      dvi = {
        config = {
          "DVI-D-1" = {
            enable = true;
            mode = "1920x1080";
            position = "0x0";
            primary = true;
            rate = "60.00";
            crtc = 0;
          };
          "DP-1".enable = false;
          "HDMI-1".enable = false;
        };
        fingerprint = {
          "DVI-D-1" = "*";
        };
      };
    };
  };
}

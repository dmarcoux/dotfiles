# User configuration for autorandr

{
  # If no monitor layout can be detected, fallback to the laptop profile (it's defined below)
  services.autorandr.defaultTarget = "laptop";

  home-manager.users.dany.programs.autorandr = {
    profiles = {
      both = {
        config = {
          "HDMI-1" = {
            enable = true;
            mode = "1920x1080";
            position = "0x0";
            primary = true;
            rate = "60.00";
            crtc = 0;
          };
          "eDP-1" = {
            enable = true;
            mode = "1920x1080";
            position = "0x1080";
            rate = "60.00";
            crtc = 1;
          };
          "DP-1".enable = false;
          "DP-2".enable = false;
          "HDMI-2".enable = false;
        };
        fingerprint = {
          "HDMI-1" = "*";
          "eDP-1" = "*";
        };
      };
      external = {
        config = {
          "HDMI-1" = {
            enable = true;
            mode = "1920x1080";
            position = "0x0";
            primary = true;
            rate = "60.00";
            crtc = 0;
          };
          "eDP-1".enable = false;
          "DP-1".enable = false;
          "DP-2".enable = false;
          "HDMI-2".enable = false;
        };
        fingerprint = {
          "HDMI-1" = "*";
        };
      };
      laptop = {
        config = {
          "eDP-1" = {
            enable = true;
            mode = "1920x1080";
            position = "0x0";
            primary = true;
            rate = "60.00";
            crtc = 0;
          };
          "DP-1".enable = false;
          "DP-2".enable = false;
          "HDMI-1".enable = false;
          "HDMI-2".enable = false;
        };
        fingerprint = {
          "eDP-1" = "*";
        };
      };
    };
  };
}

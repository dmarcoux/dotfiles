# User configuration for autorandr

{
  # Find available displays with xrandr
  home-manager.users.dany.programs.autorandr = {
    profiles = {
      laptop-and-hdmi = {
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
            position = "1920x0"; # Appears at the right of HDMI-1
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
      hdmi = {
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
      docking-external-laptop-external = {
        config = {
          "DP-2" = {
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
            position = "1920x0";
            rate = "60.00";
            crtc = 0;
          };
          "DP-1-2" = {
            enable = true;
            mode = "1920x1080";
            position = "3840x0";
            rate = "60.00";
            crtc = 0;
          };
          "DP-1".enable = false;
          "HDMI-1".enable = false;
          "HDMI-2".enable = false;
        };
        fingerprint = {
          "DP-2" = "*";
          "eDP-1" = "*";
          "DP-1-2" = "*";
        };
      };
      docking-only-externals = {
        config = {
          "DP-2" = {
            enable = true;
            mode = "1920x1080";
            position = "0x0";
            primary = true;
            rate = "60.00";
            crtc = 0;
          };
          "DP-1-2" = {
            enable = true;
            mode = "1920x1080";
            position = "3840x0";
            rate = "60.00";
            crtc = 0;
          };
          "eDP-1".enable = false;
          "DP-1".enable = false;
          "HDMI-1".enable = false;
          "HDMI-2".enable = false;
        };
        fingerprint = {
          "DP-2" = "*";
          "DP-1-2" = "*";
        };
      };
      default = { # Laptop screen only
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

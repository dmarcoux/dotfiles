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
          "HDMI-1" = "00ffffffffffff0010aca4a04c4c5430061c010380351e78ee7e75a755529c270f5054a54b00714f8180a9c0a940d1c0010101010101023a801871382d40582c45000f282100001e000000ff0058344a373138323930544c4c0a000000fc0044454c4c205532343134480a20000000fd00384c1e5311000a202020202020016e02031ff14c9005040302071601141f12132309070765030c00100083010000023a801871382d40582c45000f282100001e011d8018711c1620582c25000f282100009e011d007251d01e206e2855000f282100001e8c0ad08a20e02d10103e96000f282100001800000000000000000000000000000000000000000000000037";
          "eDP-1" = "00ffffffffffff004d1053140000000028190104a52313780ede50a3544c99260f5054000000010101010101010101010101010101011a3680a070381f40302035005ac210000018000000000000000000000000000000000000000000fe00313230334d824c513135364d31000000000002410328001200000a010a20200049";
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
          "HDMI-1" = "00ffffffffffff0010aca4a04c4c5430061c010380351e78ee7e75a755529c270f5054a54b00714f8180a9c0a940d1c0010101010101023a801871382d40582c45000f282100001e000000ff0058344a373138323930544c4c0a000000fc0044454c4c205532343134480a20000000fd00384c1e5311000a202020202020016e02031ff14c9005040302071601141f12132309070765030c00100083010000023a801871382d40582c45000f282100001e011d8018711c1620582c25000f282100009e011d007251d01e206e2855000f282100001e8c0ad08a20e02d10103e96000f282100001800000000000000000000000000000000000000000000000037";
          "eDP-1" = "00ffffffffffff004d1053140000000028190104a52313780ede50a3544c99260f5054000000010101010101010101010101010101011a3680a070381f40302035005ac210000018000000000000000000000000000000000000000000fe00313230334d824c513135364d31000000000002410328001200000a010a20200049";
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
          "eDP-1" = "00ffffffffffff004d1053140000000028190104a52313780ede50a3544c99260f5054000000010101010101010101010101010101011a3680a070381f40302035005ac210000018000000000000000000000000000000000000000000fe00313230334d824c513135364d31000000000002410328001200000a010a20200049";
        };
      };
    };
  };
}

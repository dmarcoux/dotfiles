# User configuration for autorandr

{
  home-manager.users.dany.programs.autorandr = {
    enable = true;
    profiles = {
      both = {
        config = {
          "HDMI-1" = {
            enable = true;
            gamma = "1.0:0.909:0.769";
            mode = "1920x1080";
            position = "0x0";
            primary = true;
            rate = "60.00";
            # TODO: Not possible to set CRTC with home-manager
            # crtc 0
          };
          "eDP-1" = {
            enable = true;
            gamma = "1.0:0.909:0.769";
            mode = "1920x1080";
            position = "0x1080";
            rate = "60.00";
            # TODO: Not possible to set CRTC with home-manager
            # crtc 1
          };
          "DP-1".enable = false;
          "DP-2".enable = false;
          "HDMI-2".enable = false;
        };
        fingerprint = {
          "HDMI-1" = "00ffffffffffff0009d1327f455400002a19010380351e782e9de1a654549f260d5054a56b80d1c0317c4568457c6168617c953c3168023a801871382d40582c4500132a2100001e000000ff003741463034303935534c300a20000000fd0018780f8711000a202020202020000000fc0042656e5120584c323431315a0a015c020323f15090050403020111121314060715161f202309070765030c00100083010000023a801871382d40582c4500132a2100001f011d8018711c1620582c2500132a2100009f011d007251d01e206e285500132a2100001f8c0ad08a20e02d10103e9600132a210000190000000000000000000000000000000000000000c7";
          "eDP-1" = "00ffffffffffff004d1053140000000028190104a52313780ede50a3544c99260f5054000000010101010101010101010101010101011a3680a070381f40302035005ac210000018000000000000000000000000000000000000000000fe00313230334d824c513135364d31000000000002410328001200000a010a20200049";
        };
      };
      external = {
        config = {
          "HDMI-1" = {
            enable = true;
            gamma = "1.0:0.909:0.769";
            mode = "1920x1080";
            position = "0x0";
            primary = true;
            rate = "60.00";
            # TODO: Not possible to set CRTC with home-manager
            # crtc 0
          };
          "eDP-1".enable = false;
          "DP-1".enable = false;
          "DP-2".enable = false;
          "HDMI-2".enable = false;
        };
        fingerprint = {
          "HDMI-1" = "00ffffffffffff0009d1327f455400002a19010380351e782e9de1a654549f260d5054a56b80d1c0317c4568457c6168617c953c3168023a801871382d40582c4500132a2100001e000000ff003741463034303935534c300a20000000fd0018780f8711000a202020202020000000fc0042656e5120584c323431315a0a015c020323f15090050403020111121314060715161f202309070765030c00100083010000023a801871382d40582c4500132a2100001f011d8018711c1620582c2500132a2100009f011d007251d01e206e285500132a2100001f8c0ad08a20e02d10103e9600132a210000190000000000000000000000000000000000000000c7";
          "eDP-1" = "00ffffffffffff004d1053140000000028190104a52313780ede50a3544c99260f5054000000010101010101010101010101010101011a3680a070381f40302035005ac210000018000000000000000000000000000000000000000000fe00313230334d824c513135364d31000000000002410328001200000a010a20200049";
        };
      };
      laptop = {
        config = {
          "eDP-1" = {
            enable = true;
            gamma = "1.0:0.909:0.769";
            mode = "1920x1080";
            position = "0x0";
            rate = "60.00";
            # TODO: Not possible to set CRTC with home-manager
            # crtc 0
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

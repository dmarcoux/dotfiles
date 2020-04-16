# Configuration for XFCE with i3

{ pkgs, ... }:

{
  services.xserver = {
    desktopManager.xfce = {
      enable = true; # Enable the XFCE desktop environment
      enableXfwm = false; # Disable XFCE's window manager (using i3 instead)
      noDesktop = true; # Don't install XFCE desktop components
    };

    windowManager.i3 = {
      enable = true; # Enable i3 window manager to replace Xfwm
      extraPackages = with pkgs; [
        rofi # Replace dmenu
        i3status
        lightlocker # Replace i3lock
      ];
    };

    # Set i3 as the default window manager
    windowManager.default = "i3";
  };

  # Add font-awesome to fonts for icons in workspace names
  fonts.fonts = with pkgs; [ font-awesome-ttf ];
}

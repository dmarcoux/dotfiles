# User configuration for i3

{ pkgs, ... }:

{
  # Install xfce4-terminal
  home.packages = [ pkgs.xfce.terminal ];

  xsession.windowManager.i3 = {
    enable = true; # Enable i3 window manager to replace Xfwm
    # Empty settings are instead set below in extraConfig
    config = {
      bars = [];
      focus = {
        # Window focus doesn't follow mouse movements
        followMouse = false;
      };
      fonts = ["DejaVu Sans Mono 13"];
      keybindings = {};
      modes = {};
      # Modifier key is the Windows Key
      modifier = "Mod4";
      # New containers on workspace starts in tabbed mode
      workspaceLayout = "tabbed";
    };
    extraConfig = builtins.readFile ../i3/.config/i3/config; # TODO: Split into home-manager options
  };
}

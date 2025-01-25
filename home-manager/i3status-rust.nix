# User configuration for i3status-rust

{ config, ... }:

{
  # Install and configure i3status-rust
  programs.i3status-rust = {
    enable = true;

    bars = {
      default = {
        blocks = [
          {
            block = "keyboard_layout"; # https://docs.rs/i3status-rs/latest/i3status_rs/blocks/keyboard_layout/index.html
            format = "   $layout ";
            driver = "kbddbus"; # It's started in i3, search for kbdd
          }
          {
            block = "cpu"; # https://docs.rs/i3status-rs/latest/i3status_rs/blocks/cpu/index.html
            format = "   $utilization ";
            interval = 1; # second
          }
          {
            block = "time"; # https://docs.rs/i3status-rs/latest/i3status_rs/blocks/time/index.html
            format = " $timestamp.datetime(f:'%a %e, %B %Y %T', l:fr_CA) ";
            interval = 1; # second
          }
        ];

        # Use icons from Font Awesome 6.x
        icons = "awesome6";

        # Use stylix colors
        settings.theme.overrides = config.lib.stylix.i3status-rust.bar;
      };
    };
  };
}

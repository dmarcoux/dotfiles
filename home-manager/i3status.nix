# User configuration for i3status

{ pkgs, ... }:

{
  # Install i3status
  home.packages = [ pkgs.i3status ];

  # Configure i3status
  xdg.configFile."i3status/config".text = ''
    general {
      colors = true
      interval = 1
      output_format = 'i3bar'
    }

    order += cpu_usage
    order += time

    cpu_usage {
      format = 'CPU:%usage'
      separator_block_width = 20
    }

    time {
      format = '%a %d, %B %Y %T'
    }
  '';
}

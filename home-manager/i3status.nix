# User configuration for i3status

{
  # Install and configure i3status
  programs.i3status = {
    enable = true;
    # `man i3status` for details about the configuration options
    general = {
      colors = true;
      interval = 1; # second
      output_format = "i3bar";
    };
    modules = {
      cpu_usage = {
        position = 1; # position of this module in the i3status order
        settings = {
          format = "CPU:%usage";
          separator_block_width = 20; # amount of blank pixels following the block
        };
      };
      time = {
        position = 2; # position of this module in the i3status order
        settings = {
          format = "%a %d, %B %Y %T";
        };
      };
      # Disable default modules
      ipv6.enable = false;
      "wireless _first_".enable = false;
      "ethernet _first_".enable = false;
      "battery all".enable = false;
      "disk /".enable = false;
      load.enable = false;
      memory.enable = false;
      "tztime local".enable = false;
    };
  };
}

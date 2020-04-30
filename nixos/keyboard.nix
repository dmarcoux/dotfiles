# System configuration for keyboard layout

{
  # Configure the console keymap from the xserver keyboard settings
  console.useXkbConfig = true;

  services.xserver = {
    # Set keyboard layout to Canadian Multilingual
    layout = "ca";
    xkbVariant = "multi";
    # AltGr + e for €, Swap Left Control and Caps Lock
    xkbOptions = "eurosign:e,ctrl:swapcaps";
  };
}

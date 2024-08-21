# System configuration for keyboards

{ pkgs, ... }:

{
  services.xserver.xkb = {
    # Set keyboard layout to EurKEY - https://eurkey.steffen.bruentjen.eu/layout.html
    # There's even a layout available as a template for ZSA keyboards: https://blog.zsa.io/eurkey-layout/
    layout = "eu";
    # AltGr + Space produces a normal space instead of a non-breakable space
    options = "nbsp:none";
  };

  # Enable udev rules for ZSA keyboards. This is needed to be able to flash a new configuration on the keyboards
  hardware.keyboard.zsa.enable = true;

  # Use Keymapp to flash ZSA keyboards, view current layouts/layers, optimize layouts/layers with the heatmap feature and more...
  # https://blog.zsa.io/keymapp/
  environment.systemPackages = with pkgs; [ keymapp ];


  # Configure the console keymap from the xserver keyboard settings
  console.useXkbConfig = true;
}

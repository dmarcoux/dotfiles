# System configuration for keyboards

{ pkgs, ... }:

{
  services.xserver.xkb = {
    # Set multiple keyboard layouts (This is useful when pair-programming with colleagues which are used to another layout)
    # - Canadian Multilingual: https://kbdlayout.info/kbdcan
    # - German: https://kbdlayout.info/kbdgr
    # - US: https://kbdlayout.info/kbdus
    layout = "ca(multix),de,us";
    # AltGr + Space produces a normal space instead of a non-breakable space
    # Alt + Space switches to the next keyboard layout
    options = "nbsp:none,grp:alt_space_toggle";
  };

  # Enable udev rules for ZSA keyboards. This is needed to be able to flash a new configuration on the keyboards
  hardware.keyboard.zsa.enable = true;

  # Use Keymapp to flash ZSA keyboards, view current layouts/layers, optimize layouts/layers with the heatmap feature and more...
  # https://blog.zsa.io/keymapp/
  environment.systemPackages = with pkgs; [ keymapp ];

  # Configure the console keymap from the xserver keyboard settings
  console.useXkbConfig = true;
}

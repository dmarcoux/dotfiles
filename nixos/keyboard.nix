# System configuration for keyboard layout
#
#  Canadian Multilingual custom keyboard layout:
# - AltGr + s for ß (this is the extra configuration which isn't available in `services.xserver.xkbOptions`)
# - AltGr + e for €
# - Swap Left Control and Caps Lock
# - AltGr + Space produces a normal space instead of a non-breakable space
#
# Helpful reads:
# - https://nixos.wiki/wiki/Keyboard_Layout_Customization
# - https://www.vinc17.net/unix/xkb.en.html
# - https://blog.lobraun.de/2020/03/09/Umlauts-on-US-Keyboard-Layouts-on-Ubuntu-with-XKB/
# - https://discourse.nixos.org/t/setting-custom-keyboard-layout-in-configuration-nix/1036/3

{ pkgs, ... }:

let
  # The content of `customKeyboardLayout` was created by having the following configuration active and dumping it with `setxkbmap -print > some_file.xkb`
  # The only difference is the `partial` line and `xkb_symbols` block were added to replace `xkb_symbols { include "pc+ca(multi)+inet(evdev)+ctrl(swapcaps)+eurosign(e)+nbsp(none)" };`
  #   services.xserver = {
  #     # Set keyboard layout to Canadian Multilingual
  #     layout = "ca";
  #     xkbVariant = "multi";
  #     # AltGr + e for €, Swap Left Control and Caps Lock, AltGr + Space produces a normal space instead of a non-breakable space
  #     xkbOptions = "eurosign:e,ctrl:swapcaps,nbsp:none";
  #   };
  customKeyboardLayout = pkgs.writeText "custom-keyboard-layout" ''
    xkb_keymap {
      xkb_keycodes { include "evdev+aliases(qwerty)" };
      xkb_types    { include "complete" };
      xkb_compat   { include "complete" };
      partial
      xkb_symbols "ca-multi-custom" {
          include "pc+ca(multi)+inet(evdev)+ctrl(swapcaps)+eurosign(e)+nbsp(none)"

          key <AC02>  { [s, S, ssharp, ssharp] };
      };
      xkb_geometry { include "pc(pc104)" };
    };
  '';

  # Help catch errors in the custom keyboard layout at build time
  compiledKeyboardLayout = pkgs.runCommand "compiled-keyboard-layout" {} ''
    ${pkgs.xorg.xkbcomp}/bin/xkbcomp ${customKeyboardLayout} $out
  '';
in
{
  # Install xkbcomp
  environment.systemPackages = [ pkgs.xorg.xkbcomp ];

  # Symlink custom keyboard layout file to /etc/custom-keyboard-layout
  # Looking for the Nix store path isn't needed when using this file, it's much more convenient
  environment.etc."custom-keyboard-layout".source = "${customKeyboardLayout}";

  # Load custom keyboard layout on boot/resume
  services.xserver.displayManager.sessionCommands = "${pkgs.xorg.xkbcomp}/bin/xkbcomp ${customKeyboardLayout} $DISPLAY";

  # FIXME: Load custom keyboard layout when my keyboard is plugged in
  #   To find the idVendor and idProduct, look for my keyboard in the output of `lsusb`. Connecting and disconnecting the keyboard can help by comparing the output to see what changed.
  #   Once this is clear, take the two values after `ID`. In this example `Bus 001 Device 012: ID 04d9:a096 Holtek Semiconductor, Inc. Keyboard`, the idVendor and idProduct would be `04d9` and `a096` respectively.
  # services.udev.extraRules = ''
  #   ACTION=="add", ATTRS{idVendor}=="04d9", ATTRS{idProduct}=="a096", RUN+="${pkgs.xorg.xkbcomp}/bin/xkbcomp ${customKeyboardLayout} $DISPLAY", OWNER="root"
  # '';

  # Configure the console keymap from the xserver keyboard settings
  console.useXkbConfig = true;
}

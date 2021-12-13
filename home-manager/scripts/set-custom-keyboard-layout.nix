{ pkgs, ... }:

{
  home.file."bin/set-custom-keyboard-layout" = {
    executable = true;
    text = ''
      #!${pkgs.bash}/bin/bash
      ${pkgs.xorg.xkbcomp}/bin/xkbcomp /etc/custom-keyboard-layout $DISPLAY
    '';
  };
}

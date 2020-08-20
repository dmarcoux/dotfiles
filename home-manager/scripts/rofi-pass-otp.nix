{ pkgs, ... }:

{
  home.file."bin/rofi-pass-otp" = {
    executable = true;
    text = ''
      #!${pkgs.bash}/bin/bash
      # A rofi frontend to pass-otp
      #
      # Use with: rofi -modi "pass-otp:rofi-pass-otp" -show pass-otp

      if [ -z "$*" ]; then
        # rofi first calls the script with no arguments

        # List full paths of entries stored by pass under $PASSWORD_STORE_DIR
        # Keep the relative paths of these entries without the .gpg extension (just like how pass does it)
        fd ".gpg$" "$PASSWORD_STORE_DIR" | sed -e "s|$PASSWORD_STORE_DIR/\(.*\)\.gpg|\1|g" | sort
      else
        # Once the user selected an entry, rofi calls the script again with the selected entry as an argument

        # Retrieve the one-time password for the selected entry and type it out in the focused window
        # Note: coproc starts the command group ({ ... }) as a background job (so it doesn't freeze rofi)
        coproc { pass otp "$*" | xdotool type --clearmodifiers --file - > /dev/null & }
      fi
    '';
  };
}

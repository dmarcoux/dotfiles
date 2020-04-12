#!/usr/bin/env bash

# A rofi frontend to pass
#
# Use with: rofi -modi "pass:~/dotfiles/scripts/rofi-pass.sh" -show pass

if [ -z "$*" ]; then
  # rofi first calls the script with no arguments

  # List full paths of entries stored by pass under $PASSWORD_STORE_DIR/pass
  # Keep the relative paths of these entries without the .gpg extension (just like how pass does it)
  find "$PASSWORD_STORE_DIR/pass" -name "*.gpg" -print | sed -e "s|$PASSWORD_STORE_DIR/\\(.*\\)\\.gpg|\\1|g" | sort
else
  # Once the user selected an entry, rofi calls the script again with the selected entry as an argument

  # Retrieve the password for the selected entry and copy it to the clipboard
  # Note: coproc starts the command group ({ ... }) as a background job (so it doesn't freeze rofi)
  coproc { pass show "$*" | xdotool type --clearmodifiers --file - > /dev/null & }
fi

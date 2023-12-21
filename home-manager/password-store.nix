# User configuration for password-store

{ pkgs, config, ... }:

{
  programs.password-store = {
    enable = true;
    # Install password-store with the pass-otp extension
    package = pkgs.pass.withExtensions (exts: [ exts.pass-otp ]);
    # Set environment variables used by password-store and its extensions
    settings = {
      PASSWORD_STORE_DIR = "${config.xdg.configHome}/password-store/passwords";
      PASSWORD_STORE_GENERATED_LENGTH = "30";
    };
  };

  # Install xdotool to type passwords
  home.packages = [pkgs.xdotool];

  # TODO: Make this script a password-store extension, see https://www.passwordstore.org/#extensions
  home.file."bin/new_password" = {
    executable = true;
    text = ''
      #!${pkgs.bash}/bin/bash
      # Create password in the password store

      # Exit immediately if a command exits with a non-zero status, like when interrupted with Ctrl+C
      set -e

      DIRECTORY=$(gum choose --header="Select a directory for the password" "me" "work")

      # Enforce the presence of an identifier by looping until it isn't an empty string
      while [[ -z "$IDENTIFIER" ]]; do
        IDENTIFIER=$(gum input --header="Write the identifier for the password" --placeholder="example.com")
      done

      ACCOUNT=$(gum input --header="Write the account associated to the password" --placeholder="Username/Email/Login/etc...")

      PASSWORD_FILE="$DIRECTORY/$IDENTIFIER"

      pass insert "$PASSWORD_FILE"

      # If no account was provided, we're done
      if [[ -n "$ACCOUNT" ]]; then
        PASSWORD=$(pass show "$PASSWORD_FILE")

        pass insert --multiline --force "$PASSWORD_FILE" <<< $(echo -e "$PASSWORD\nUsername: $ACCOUNT")
      fi
    '';
  };


  # Helper functions for common tasks
  programs.zsh.initExtra = ''
    generate_password(){
       if [ -z "$1" ]; then
        # Display usage if no parameters given
        echo "Usage: ''${funcstack[1]} me/some_website.com[=account] [password_length] (Account is the email/username in the login. If not provided, it's keeping the current username)"
        return
      fi

      password_file="$1"
      password_file_without_username=$(echo "$password_file" | sed -e "s|^\(.*\)=.*|\1|g")

      echo "$PASSWORD_STORE_DIR/$password_file_without_username"
      # The password file already exists, so we generate a new password in place and we're done
      if [ -f "$PASSWORD_STORE_DIR/$password_file_without_username.gpg" ]; then
        # Whenever the password length ("$2") wasn't provided, it will default to PASSWORD_STORE_GENERATED_LENGTH
        pass generate --in-place --no-symbols --clip "$password_file_without_username" "$2"

        return
      fi

      # The password file doesn't exist, so we generate a password
      # Whenever the password length ("$2") wasn't provided, it will default to PASSWORD_STORE_GENERATED_LENGTH
      pass generate --no-symbols --clip "$password_file_without_username" "$2"

      # A username was not provided, so we're done
      if [ "$password_file" = "$password_file_without_username" ]; then
        return
      fi

      # A username was provided, so we need to overwrite the existing file to add the username
      username=$(echo "$password_file" | sed -e "s|^.*=\(.*\)|\1|g");
      password=$(pass "$password_file_without_username");

      pass insert --multiline --force "$password_file_without_username" <<< $(echo -e "$password\nUsername: $username")
    }

    # Setup new two-factor authentication code from a QR code image
    new_2fa(){
      if [ -z "$1" ] || [ -z "$2" ]; then
        echo "Usage: ''${funcstack[1]} qr_code.jpg work/some_website.com"
        return
      fi

      zbarimg --quiet --raw "$1" | pass otp append "$2"
    }
  '';
}

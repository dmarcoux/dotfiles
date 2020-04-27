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

  # Helper functions for common tasks
  programs.zsh.initExtra = ''
    # Setup new password
    new_password(){
      if [ -z "$1" ]; then
        # Display usage if no parameters given
        echo "Usage: ''${funcstack[1]} me/some_website.com=account (account is the email/username in the login)"
        return
      fi

      pass insert "pass/$1"
    }

    # Setup new generated password
    new_generated_password(){
       if [ -z "$1" ]; then
        # Display usage if no parameters given
        echo "Usage: ''${funcstack[1]} me/some_website.com=account [password_length] (account is the email/username in the login)"
        return
      fi

      # Whenever the password length ("$2") wasn't provided, it will default to PASSWORD_STORE_GENERATED_LENGTH
      pass generate --no-symbols --clip "pass/$1" "$2"
    }

    # Setup new two-factor authentication code from a QR code image
    new_2fa(){
      if [ -z "$1" ] || [ -z "$2" ]; then
        echo "Usage: ''${funcstack[1]} qr_code.jpg work/some_website.com=account (account is the email/username in the login)"
        return
      fi

      zbarimg --quiet --raw "$1" | pass otp insert "otp/$2"
    }
  '';
}

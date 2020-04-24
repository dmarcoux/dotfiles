# User configuration for password-store

{ pkgs, ... }:

{
  programs.password-store = {
    enable = true;
    # Install password-store with the pass-otp extension
    package = pkgs.pass.withExtensions (exts: [ exts.pass-otp ]);
    # Set environment variables used by password-store and its extensions
    settings = {
      # TODO: Use $XDG_CONFIG_HOME
      PASSWORD_STORE_DIR = "/home/dany/.config/password-store/passwords";
      PASSWORD_STORE_GENERATED_LENGTH = "30";
    };
  };

  # Install xdotool to type passwords
  home.packages = [pkgs.xdotool];
}

# Configuration for password-store

{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Install password-store and its pass-otp extension
    (pass.withExtensions (exts: [ exts.pass-otp ]))
    # Install xdotool to type passwords
    xdotool
  ];
}

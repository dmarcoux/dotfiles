# System configuration for YubiKey

{ pkgs, ... }:

{
  # Enable PCSC-Lite daemon to use smart card mode (CCID) mode (also needed for Yubico Authenticator)
  services.pcscd.enable = true;

  # Setup the udev rules from the yubikey-personalization package (needed to recognize YubiKeys in Yubico Authenticator)
  services.udev.packages = [ pkgs.yubikey-personalization ];

  # Install packages
  environment.systemPackages = with pkgs; [
    # Provides ykman CLI for configuring any YubiKey over all USB interfaces
    yubikey-manager
    # Use Yubico Authenticator to store OATH credentials on YubiKeys
    yubioath-flutter
  ];
}

# System configuration for GnuPG

{ pkgs, ... }:

{
  programs.gnupg.agent = {
    enable = true;

    # Use GnuPG agent with SSH support
    enableSSHSupport = true;

    # Set the pinentry interface to use
    pinentryPackage = pkgs.pinentry-gnome3;

    settings = {
      # Cache the GPG key for 4 hours
      default-cache-ttl = 14400; # number of seconds
      # Cache the SSH key for 4 hours
      default-cache-ttl-ssh = 14400; # number of seconds
    };
  };
}

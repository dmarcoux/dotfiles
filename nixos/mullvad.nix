# System configuration for Mullvad VPN

{ pkgs-unstable, ... }:

{
  services.mullvad-vpn = {
    # Start the Mullvad daemon
    enable = true;

    # Install the Mullvad package with the CLI and GUI
    # Using unstable to always have the latest version available
    package = pkgs-unstable.mullvad-vpn;
  };
}

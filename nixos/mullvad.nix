# System configuration for Mullvad VPN

{ pkgs, ... }:

{
  services.mullvad-vpn = {
    # Start the Mullvad daemon
    enable = true;

    # Install the Mullvad package with the CLI and GUI
    package = pkgs.mullvad-vpn;
  };
}

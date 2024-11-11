# System configuration for 1Password
# Documentation at https://nixos.wiki/wiki/1Password

{ pkgs-unstable, ... }:

{
  programs._1password = {
    # Install 1Password CLI
    enable = true;
    # Always get the latest version available
    package = pkgs-unstable._1password-cli;
  };

  # Install and configure 1Password GUI
  programs._1password-gui = {
    enable = true;
    # Always get the latest version available
    package = pkgs-unstable._1password-gui;

    # Certain features, including CLI integration and system authentication support, require enabling PolKit integration
    polkitPolicyOwners = [ "dany" ];
  };
}

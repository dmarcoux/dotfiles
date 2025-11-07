# User configuration with home-manager
# https://nix-community.github.io/home-manager/options.html

{
  # Enable home-manager to start the X session (otherwise graphical services are not started automatically)
  xsession.enable = true;

  # Set configuration defaults
  home = {
    homeDirectory = "/home/dany";
    # Switching to a higher state version typically requires performing some manual steps, such as data conversion or moving files
    # See release notes for state version changes: https://nix-community.github.io/home-manager/release-notes.html
    stateVersion = "25.05";
    username = "dany";
  };
}

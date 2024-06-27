# System configuration for GNOME Keyring
# It cannot be done in home-manager: https://github.com/nix-community/home-manager/issues/1454

{
  # Launch GNOME Keyring to store security credentials. It's used by many applications like JetBrains IDEs to store database passwords
  services.gnome.gnome-keyring.enable = true;

  # Install Seahorse to view/manage encryption keys and passwords in the GNOME Keyring
  programs.seahorse.enable = true;

  # For GNOME Keyring to unlock by default
  services.xserver.updateDbusEnvironment = true;
}

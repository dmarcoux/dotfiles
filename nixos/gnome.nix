# System configuration for GNOME

{ pkgs, ... }:

{
  services.xserver = {
    # Enable GDM, the GNOME Display Manager
    displayManager.gdm.enable = true;

    # Enable GNOME desktop manager
    desktopManager.gnome.enable = true;
  };

  # TODO: Go through all the GNOME apps and add the ones I don't need in the list below
  # Exclude packages which are otherwise pre-installed in GNOME
  environment.gnome.excludePackages = (with pkgs; [
    gedit # Text editor
    gnome-photos
    gnome-tour # Guided tour and greeter for GNOME
  ]) ++ (with pkgs.gnome; [
    cheese # Webcam tool
    gnome-music # Music player
    gnome-terminal
    epiphany # Web browser
    geary # Email reader
    totem # Video player
    tali # Poker game
    iagno # Go game
    hitori # Sudoku game
    atomix # Puzzle game
  ]);
}
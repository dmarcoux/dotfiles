# User configuration for XDG base directories

{ pkgs, lib, ... }:

{
  home.packages = [ pkgs.xdg-user-dirs ];

  xdg = {
    # Enable management of XDG base directories
    enable = true;
    # Enable management of user directories
    userDirs = {
      # Setup default user directories (Desktop, Documents, Downloads, Music, Pictures, Public, Templates and Videos)
      enable = true;
      # Setup extra user directories
      extraConfig = {
        XDG_AUDIO_DIR = "$HOME/Audio";
        XDG_PROJETS_DIR = "$HOME/Projets";
      };
    };
  };

  # Generate the user directories defined above with `xdg.userDirs`
  home.activation.xdg-user-dirs-update = lib.hm.dag.entryAfter ["writeBoundary"] ''
    $DRY_RUN_CMD ${pkgs.xdg-user-dirs}/bin/xdg-user-dirs-update
  '';
}

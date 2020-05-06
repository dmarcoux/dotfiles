# User configuration for git

{ pkgs, config, ... }:

{
  # Install extra packages
  home.packages = with pkgs; [
    git-crypt
    gitAndTools.hub
  ];

  programs.git = {
    # Install git
    enable = true;

    extraConfig = {
      branch = { autoSetupRebase = "always"; };
      core = {
        editor = "vim";
        # Use the same path as defined upstream: https://github.com/rycee/home-manager/blob/ad8b644de19aca8a7534c9695a7446b258156d06/modules/programs/git.nix#L223
        excludesFile = "${config.xdg.configHome}/git/ignore";
        fileMode = true;
      };
      diff = {
        algorithm = "histogram";
        compactionHeuristic = true;
        wsErrorHighlight = "all";
      };
      fetch = { prune = true; };
      push = {
        default = "current";
        followTags = true;
      };
      stash = { showPatch = true; };
      status = { showUntrackedFiles = "all"; };
      user = {
        email = "dmarcoux@posteo.de";
        name = "Dany Marcoux";
      };
    };

    # List of paths that should be globally ignored
    ignores = [ "*.swp" ];

    # Install and setup git-lfs
    lfs.enable = true;

    # Sign commits using GnuPG
    signing = {
      key = "82FA5A4A";
      signByDefault = true;
    };
  };
}

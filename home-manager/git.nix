# User configuration for git

{ pkgs, config, ... }:

{
  # Install hub
  home.packages = [ pkgs.gitAndTools.hub ];

  programs.git = {
    # Install git only, nothing extra like the `send-email` command
    enable = true;
    package = pkgs.gitMinimal;

    extraConfig = {
      branch = { autoSetupRebase = "always"; };
      core = {
        editor = "code --wait";
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

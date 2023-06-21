# User configuration for git

{ pkgs, config, ... }:

{
  # Install extra packages
  home.packages = with pkgs; [
    git-crypt
  ];

  programs.git = {
    # Install git
    enable = true;
    package = pkgs.gitFull;

    # Install and setup delta (https://github.com/dandavison/delta)
    delta = {
      enable = true;
      options = {
        # See available themes with `delta --list-syntax-themes`
        syntax-theme = "Solarized (light)";
      };
    };

    extraConfig = {
      branch = { autoSetupRebase = "always"; };
      core = {
        editor = "hx";
        # Use the same path as defined upstream: https://github.com/nix-community/home-manager/blob/ad8b644de19aca8a7534c9695a7446b258156d06/modules/programs/git.nix#L223
        excludesFile = "${config.xdg.configHome}/git/ignore";
        fileMode = true;
      };
      diff = {
        algorithm = "histogram";
        compactionHeuristic = true;
        wsErrorHighlight = "all";
      };
      fetch = { prune = true; };
      init = { defaultBranch = "main"; };
      push = {
        default = "current";
        followTags = true;
      };
      rebase = {
        autoSquash = true;
      };
      stash = { showPatch = true; };
      status = { showUntrackedFiles = "all"; };
      user = {
        email = "dmarcoux@posteo.de";
        name = "Dany Marcoux";
      };
    };

    # List of paths that should be globally ignored
    # While those files are usually never tracked, adding them is still possible with `git add --force filename`
    ignores = [
      "*.swp"
      ".bash_history"
      # Local nix-shell whenever a project doesn't have a development environment
      "shell.local.nix"
      ".nix-mix.local"
      ".nix-hex.local"
    ];

    # Install and setup git-lfs
    lfs.enable = true;

    # Sign commits using GnuPG
    signing = {
      key = "82FA5A4A";
      signByDefault = true;
    };
  };

  # Install and configure GitHub CLI (https://cli.github.com/)
  programs.gh = {
    enable = true;
    settings = {
      # What protocol to use when performing git operations. Supported values: ssh, https
      git_protocol = "ssh";
    };
  };
}

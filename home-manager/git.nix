# User configuration for git

{ pkgs, config, ... }:

{
  # Install extra packages
  home.packages = with pkgs; [
    git-crypt
    # GitHub CLI (https://cli.github.com/)
    gitAndTools.gh
  ];

  programs.git = {
    # Install git
    enable = true;

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
        editor = "nvim";
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
      stash = { showPatch = true; };
      status = { showUntrackedFiles = "all"; };
      user = {
        email = "dmarcoux@posteo.de";
        name = "Dany Marcoux";
      };
    };

    # List of paths that should be globally ignored
    ignores = [ "*.swp" "shell.nix" ];

    # Install and setup git-lfs
    lfs.enable = true;

    # Sign commits using GnuPG
    signing = {
      key = "82FA5A4A";
      signByDefault = true;
    };
  };

  # Configure GitHub CLI (programs.gh from home-manager is not working since the config format is JSON... instead of YAML)
  xdg.configFile."gh/config.yml".text = ''
    # What protocol to use when performing git operations. Supported values: ssh, https
    git_protocol: ssh
    # What editor gh should run when creating issues, pull requests, etc. If blank, will refer to environment.
    editor:
    # When to interactively prompt. This is a global config that cannot be overridden by hostname. Supported values: enabled, disabled
    prompt: enabled
    # A pager program to send command output to, e.g. "less". Set the value to "cat" to disable the pager.
    pager:
    # Aliases allow you to create nicknames for gh commands
    aliases:
  '';
}

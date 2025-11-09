# User configuration for git

{ pkgs, lib, config, ... }:

let
  # My public SSH key
  sshKey = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDUwJdHmZu1Cz8kLQTGtKxpzneRJw3p0wskhRi+wUtRx3of3Hakcceiw8n6N6UJQ7vpe9MoJv/e9IkdZyp5/QvHEdI/ZrrLkWc+WzFuC1nDMuu0yiV7TLEn1E63EQDgZCrsPgqOElYm51+zL4sL3ISMF7yedi2zdZNAI/kBVWaurxy2Szkw/0c+KfT8N+YO1FKJLTo9KP8hs2I7x7SUrIsPMLDYSvS//i4O9/HCZgj43StYDxfgAIgWAeD1Q5gHrjlFdmueESFeXGBDNLJwJE8LUrMUqgg9+smwt3nH/NW+klQmWzy0y9dpb5sbfHSz2PnoE3aCTNCAaFQe14oE+cN2xPyvG0Uueeg3fIFJvTZMGJB9G+g1IG2PeYo6UvarxcfUDiwEYhw9gZG9nS7+gZGnbcuezIeq7xzrW5jLnCaCI/R7vHK3yN0/8VerX7VU3CXcmMGldsaKd0QxDk1aArVqLNR+tgYpAj2MIFOprYz0oNUOKrqSlfmyVQOIbeqcnTa+IhV7uP+hjuwO6HFbkn3im6n7BGVX7aTTe/RGQBbbR9qad6Of3bRJJe0ukLwti3R4Vtx8RJ1vZ5v/k4rTHM24AzlXd6QtP3KHZ1PPJcT9nFQtQ8gcCPrP2ACXo6p9KGH5caIBAy8dDWFWgwtsvQbDsbogOOQLh4Gbtm5ymIgOcw==";
in
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
        syntax-theme = "base16-stylix";
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
      fetch = {
        # Fetch all remotes
        all = true;
        # When fetching, remove remote-tracking references and tags which no longer exist on the remote
        prune = true;
        pruneTags = true;
      };
      # When a wrong command is given, git prompts for confirmation to autocorrect the command if it identifies exactly one similar valid command
      help = { autoCorrect = "prompt"; };
      init = { defaultBranch = "main"; };
      push = {
        default = "current";
        followTags = true;
      };
      tag = {
        # Sort git tags by treating dotted version numbers as a series of integer values, so 1.101 is displayed before 1.1000
        sort = "version:refname";
      };
      rebase = {
        autoSquash = true;
      };
      stash = { showPatch = true; };
      status = { showUntrackedFiles = "all"; };
      user = {
        email = "git@dmarcoux.com";
        name = "Dany Marcoux";
      };
      # Sign commits with SSH. 1Password stores the SSH key used in signing commits
      # https://developer.1password.com/docs/ssh/git-commit-signing
      commit = { gpgsign = true; }; # To avoid including the `-S` flag with each commit
      gpg = {
        format = "ssh";
        ssh = {
          # To avoid having to set SSH_AUTH_SOCK myself, this is handled by 1Password GUI
          program = "${lib.getExe' pkgs._1password-gui "op-ssh-sign"}";
          # To be able to verify commit signatures locally with `git log --show-signature`
          allowedSignersFile = "${config.home.homeDirectory}/.ssh/allowed_signers";
        };
      };
      # Use my public SSH key to sign git commits
      user.signingKey = "${sshKey}";
    };

    # List of paths that should be globally ignored
    # While those files are usually never tracked, adding them is still possible with `git add --force filename`
    ignores = [
      "nohup.out" # From nohup
      "*.swp"
      ".bash_history"
      # Local nix-shell whenever a project doesn't have a development environment
      "shell.local.nix"
      ".nix-mix.local" # Elixir
      ".nix-hex.local" # Elixir
      ".bundle" # Ruby, this is almost always included in .gitignore, but just in case I ignored it too...
      ".idea" # JetBrains IDEs
      ".~lock.*.odt" # Lock files from LibreOffice
    ];

    # Install and setup git-lfs
    lfs.enable = true;
  };

  # Allow signing git commits with my SSH key
  home.file.".ssh/allowed_signers".text = "* ${sshKey}";

  # Install and configure GitHub CLI (https://cli.github.com/)
  programs.gh = {
    enable = true;
    settings = {
      # What protocol to use when performing git operations. Supported values: ssh, https
      git_protocol = "ssh";
    };
  };
}

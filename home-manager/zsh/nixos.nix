{
  programs.zsh.initExtra = ''
    # Delete all generations older than 14 days for all profiles
    ealias ncgd='sudo nix-collect-garbage --delete-older-than 14d'

    # List subscribed channels
    ealias ncl='sudo nix-channel --list'

    # Update and activate channels
    ealias ncu='sudo nix-channel --update'

    # Build the configuration and make it the default boot option, then activate it
    ealias nrs='sudo nixos-rebuild switch'

    # Build the configuration and make it the default boot option, but don't activate it until the next reboot
    ealias nrb='sudo nixos-rebuild boot'

    # Search for a package
    ealias ns='nix search'
    ealias nsu='nix search --update-cache'

    # Start default devShell of Nix Flakes in `flake.nix`
    ealias ndev='nix develop'

    # Start a pure nix-shell
    ealias nsp='nix-shell --pure'
    # Start a pure nix-shell, but this is one is globally ignored by Git. Useful for projects in which having a nix-shell isn't an option
    ealias nspl='nix-shell --pure shell.local.nix'

    # Show differences between two NixOS generations
    nixos_generation_diffs(){
      if [ -z "$2" ]; then
        # Display usage if less than 2 parameters were given
        echo "Usage: ''${funcstack[1]} OLDER_GENERATION_NUMBER YOUNGER_GENERATION_NUMBER"
        return
      fi

      nix store diff-closures "/nix/var/nix/profiles/system-$1-link" "/nix/var/nix/profiles/system-$2-link" | less
    }

    # Show incremental differences between all NixOS generations on my system
    ealias npdc='nix profile diff-closures --profile /nix/var/nix/profiles/system | less'
  '';
}

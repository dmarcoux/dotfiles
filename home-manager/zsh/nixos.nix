{
  programs.zsh.initExtra = ''
    # Delete all generations older than 14 days for all profiles
    ealias ncgd='sudo nix-collect-garbage --delete-older-than 14d'

    # List subscribed channels
    ealias ncl='sudo nix-channel --list'

    # Update and activate channels
    ealias ncu='sudo nix-channel --update'

    # Build, activate and update boot default
    ealias nrs='sudo nixos-rebuild switch'

    # Search for a package
    ealias ns='nix search'
    ealias nsu='nix search --update-cache'

    # Start a pure nix-shell
    ealias nsp='nix-shell --pure'

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

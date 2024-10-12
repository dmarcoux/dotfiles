{
  programs.bash.initExtra = ''
    # Delete all generations older than 14 days for all profiles
    alias ncgd='sudo nix-collect-garbage --delete-older-than 14d'

    # List subscribed channels
    alias ncl='sudo nix-channel --list'

    # Update and activate channels
    alias ncu='sudo nix-channel --update'

    # Build the configuration and make it the default boot option, then activate it
    alias nrs='sudo nixos-rebuild switch --flake ~/dotfiles'

    # Build the configuration and make it the default boot option, but don't activate it until the next reboot
    alias nrb='sudo nixos-rebuild boot --flake ~/dotfiles'

    # Search for a package
    alias ns='nix search'
    alias nsu='nix search --update-cache'

    # Start default devShell of Nix Flakes in `flake.nix`
    alias ndev='nix develop'

    # Start a pure nix-shell
    alias nsp='nix-shell --pure'
    # Start a pure nix-shell, but this is one is globally ignored by Git. Useful for projects in which having a nix-shell isn't an option
    alias nspl='nix-shell --pure shell.local.nix'

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
    alias npdc='nix profile diff-closures --profile /nix/var/nix/profiles/system | less'
  '';
}

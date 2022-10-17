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
  '';
}

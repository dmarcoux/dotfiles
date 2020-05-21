{
  programs.zsh.initExtra = ''
    # Delete all old generations of all profiles
    ealias ncgd='sudo nix-collect-garbage --delete-old'
    # List subscribed channels
    ealias ncl='sudo nix-channel --list'
    # Update and activate channels
    ealias ncu='sudo nix-channel --update'
    # Build, activate and update boot default
    ealias nrs='sudo nixos-rebuild switch'
    # Search for a package
    ealias nsu='nix search --update-cache'
  '';
}

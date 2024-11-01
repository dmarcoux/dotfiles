# System configuration for devenv

{ pkgs-unstable, ... }:

{
    # Fast, Declarative, Reproducible and Composable Developer Environments using Nix (https://devenv.sh/)
    environment.systemPackages = [ pkgs-unstable.devenv ];

    # Add my user to the trusted users to let devenv manage binary caches of the Nix store
    nix.extraOptions = ''
        trusted-users = root dany
    '';
}

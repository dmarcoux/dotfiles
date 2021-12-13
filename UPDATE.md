### How to Update to a New NixOS Version

Change Nix channels by overwriting them (replace `VERSION_NUMBER` with the new version):

```
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-VERSION_NUMBER.tar.gz home-manager
sudo nix-channel --add https://nixos.org/channels/nixos-VERSION_NUMBER nixos
```

Activate channels:

```
sudo nix-channel --update
```

In [home-manager/home.nix](home-manager/home.nix), set `stateVersion` to the new
version. Check home-manager's release notes if something needs to be changed.

Build the NixOS system with the new NixOS version:

```
sudo nixos-rebuild switch
```

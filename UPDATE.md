### How to Update to a New NixOS Version

1. Update the following inputs in [flake.nix](./flake.nix) to use the new NixOS version:
   - `nixpkgs`
   - `home-manager`
   - `stylix`

2. Update state version for NixOS and Home Manager

   2.1 Check the release notes if something needs to be changed.
     - [NixOS](https://nixos.org/manual/nixos/stable/release-notes.html#ch-release-notes)
     - [Home Manager](https://nix-community.github.io/home-manager/release-notes.xhtml)

   2.2 Apply the changes if needed.

   2.3 Update state version.
     - NixOS: `system.stateVersion` in [nixos/configuration.nix](nixos/configuration.nix)
     - Home Manager: `home.stateVersion` in [home-manager/home.nix](home-manager/home.nix)

3. Update [flake.lock](./flake.lock) to use the new inputs

   ```bash
   nix flake update
   ```

3. Build the NixOS system with the new NixOS version, then reboot

   ```bash
   sudo nixos-rebuild boot --flake ~/dotfiles
   reboot
   ```

### How to Update to a New NixOS Version

1. Change `nixos` channel by overwriting it (replace `VERSION_NUMBER` with the new version, like `22.11`)

   ```bash
   sudo nix-channel --add https://nixos.org/channels/nixos-VERSION_NUMBER nixos
   ```

2. Change the version of the home-manager import in [nixos/home-manager.nix](nixos/home-manager.nix)

3. Update channels

   ```bash
   sudo nix-channel --update
   ```

4. Update state version for NixOS and Home Manager

   3.1 Check the release notes if something needs to be changed.
     - [NixOS](https://nixos.org/manual/nixos/stable/release-notes.html#ch-release-notes)
     - [Home Manager](https://nix-community.github.io/home-manager/release-notes.xhtml)

   3.2 Apply the changes if needed.

   3.3 Update state version.
     - NixOS: `system.stateVersion` in [nixos/configuration.nix](nixos/configuration.nix)
     - Home Manager: `home.stateVersion` in [home-manager/home.nix](home-manager/home.nix)

5. Build the NixOS system with the new NixOS version, then reboot

   ```bash
   sudo nixos-rebuild boot
   reboot
   ```

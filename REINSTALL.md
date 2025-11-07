# Before Reinstallation

1. Backup any data which isn't already backed up somewhere else.

   - Shell history (zsh)
   - Music under $XDG_MUSIC_DIR (I have a backup, but make sure it's really up-to-date)
   - Chrome bookmarks (They should all be in my bookmark manager)
   - Firefox bookmarks should be synced with my Mozilla account, but double-check
   - Files under $XDG_DOWNLOAD_DIR

2. Commit and push changes for my Git repositories.

   - dotfiles
   - Everything under $XDG_PROJETS_DIR

# Reinstall NixOS on a Configured Host

Configured hosts are tracked in this repository under [hosts/](hosts/).

1. In the *Live ISO*, search for `Keyboard` in the OS settings to then set the keyboard layout to `Canadian (CSA)` (it's under `French (Canada)`).

2. Switch to the root user.

   ```bash
   sudo su -
   ```

3. Download this repository as a ZIP archive and extract its content at
   `/tmp/dotfiles` (with `-L`, `curl` follows redirects)

   ```bash
   curl -L https://github.com/dmarcoux/dotfiles/archive/refs/heads/main.zip --output /tmp/dotfiles.zip &&
   unzip /tmp/dotfiles.zip -d /tmp &&
   mv /tmp/dotfiles-main /tmp/dotfiles
   ```

4. Set the hostname from one of the configured hosts under `/tmp/dotfiles/hosts/`.

   _Lists the configured hosts_

   ```bash
   ls /tmp/dotfiles/hosts/
   ```

   _Set the hostname_

   ```bash
   export HOSTNAME="PICK_A_HOST"
   ```

5. To partition, format, and mount the disks, I use [disko](https://github.com/nix-community/disko).
   Reuse the disko configuration for the host, or create one. Either way, ensure
   the disk names match what `lsblk` outputs.

   _Example of `lsblk` output_

   ```bash
   NAME        MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
   sda           8:0    0   1.8T  0 disk
   nvme0n1     259:0    0 476.9G  0 disk
   ```

   In this example, the disk names are `/dev/sda` and `/dev/nvme0n1`.

   _Example of a disko configuration and where to put the disk names_

   ```nix
   # ...
   main = {
     type = "disk";
     device = "/dev/sda";
     content = {
       type = "gpt";
   # ...
   ```
6. If encrypting disks with LUKS:

   1. Wipe disks before proceeding

      ```bash
      dd if=/dev/zero of=DISK bs=1M status=progress
      ```

   2. Set passphrase to decrypt disks on boot

      ```bash
      echo -n "password" > /tmp/secret.key
      ```

7. Run disko to partition, format, and mount the disks.

   **This will erase any existing data on the disks.**

   ```bash
   nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount "/tmp/dotfiles/hosts/$HOSTNAME/disko-config.nix"
   ```

8. Find and comment out the various `secrets` imports in the root `home-manager`
   and `NixOS` Nix files (The repository with secrets isn't cloned yet)

   ```bash
   grep -rni "secrets" /tmp/dotfiles/*
   ```

9. Generate NixOS configuration files

   ```bash
   nixos-generate-config --no-filesystems --root /mnt
   ```

   Differences between those generated files and the ones under
   `/tmp/dotfiles/hosts/$HOSTNAME` will be committed and pushed after rebooting.

10. Install NixOS for the given host.

    ```bash
    nixos-install --flake "/tmp/dotfiles#$HOSTNAME"
    ```

11. Reboot

    ```bash
    reboot
    ```

-----

1. Log in as `root` with the password set in the NixOS installation

2. Open a terminal and set password for my user

   ```bash
   passwd dany
   ```

3. Log out

   ```bash
   logout
   ```

4. Log in as my user

5. Setup 1Password, my password manager. The settings for the CLI, desktop and
   browser extensions are explained in one of the secure notes.

6. Clone the dotfiles repository

   ```bash
   git clone git@github.com:dmarcoux/dotfiles.git ~/dotfiles
   ```

7. Setup `secrets` gitsubmodule

   ```bash
   cd ~/dotfiles &&
   git submodule init &&
   git submodule update &&
   cd secrets &&
   echo "Follow instructions from the Setup section in secrets' README"
   ```

8. Compare files under `/etc/nixos/` with their equivalents in my dotfiles.
   Commit and push all differences.

9. Build the NixOS system for the host.

   ```bash
   sudo nixos-rebuild boot --flake /home/dany/dotfiles
   ```

10. Reboot

    ```bash
    reboot
    ```

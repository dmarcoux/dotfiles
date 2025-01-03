# Before Installation

If possible, do this on the previous host:

1. Backup any data which isn't already backed up somewhere else.

   - Shell history (zsh)
   - Music under $XDG_MUSIC_DIR (I have a backup, but make sure it's really up-to-date)
   - Chrome bookmarks (They should all be in my bookmark manager)
   - Firefox bookmarks should be synced with my Mozilla account, but double-check
   - Files under $XDG_DOWNLOAD_DIR

2. Commit and push changes for my Git repositories.

   - dotfiles
   - Everything under $XDG_PROJETS_DIR


# Install NixOS on a New Host

1. Switch to the root user.

   ```bash
   sudo su -
   ```

2. Download this repository as a ZIP archive and extract its content at
   `/tmp/dotfiles` (with `-L`, `curl` follows redirects)

   ```bash
   curl -L https://github.com/dmarcoux/dotfiles/archive/refs/heads/main.zip --output /tmp/dotfiles.zip &&
   unzip /tmp/dotfiles.zip -d /tmp &&
   mv /tmp/dotfiles-main /tmp/dotfiles
   ```

3. To partition, format, and mount the disks, I use
   [disko](https://github.com/nix-community/disko). Create or adapt one of the
   disko configurations from the dotfiles. Either way, ensure the disk names match
   what `lsblk` outputs.

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

4. Run disko to partition, format and mount the disks.

   **This will erase any existing data on the disks.**

   ```bash
   nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount /tmp/path/to/disko-config.nix
   ```

5. Create `configuration.nix` for the system, but without the filesystems. Those
   are handled by `disko`.

   ```bash
   nixos-generate-config --no-filesystems --root /mnt
   ```

6. Set hostname, move the dotfiles on the mounted disks, and create a host in the dotfiles.

   ```bash
   export HOSTNAME="PICK_A_NAME" &&
   mv /tmp/dotfiles /mnt/etc/nixos/ &&
   mkdir -p "/mnt/etc/nixos/dotfiles/hosts/$HOSTNAME" &&
   mv /mnt/etc/nixos/*.nix "/mnt/etc/nixos/dotfiles/hosts/$HOSTNAME/"
   ```

   _Add the new host inside `nixosConfigurations = { ... }`_
   ```bash
   vim /mnt/etc/nixos/dotfiles/flake.nix
   ```

7. Edit the Nix configuration files for the host.

   ```bash
   vim "/mnt/etc/nixos/dotfiles/hosts/$HOSTNAME/*.nix"
   ```

8. Install NixOS for the new host.

   ```bash
   nixos-install --flake "/mnt/etc/nixos/dotfiles#$HOSTNAME"
   ```

9. Reboot

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

8. Copy over the files from `/etc/nixos/dotfiles` to the dotfiles repository.

9. Commit and push the changes to the dotfiles repository.

10. Build the NixOS system for the host. Its hostname matches one of the
    directories under [hosts/](hosts/).

    ```bash
    sudo nixos-rebuild boot --flake /home/dany/dotfiles
    ```

11. Reboot

    ```bash
    reboot
    ```

### Install From Scratch on a NixOS System

1. Set [partitions and filesystems](https://nixos.org/nixos/manual/index.html#sec-installation-partitioning)

   TODO: Give [disko](https://github.com/nix-community/disko) a try.

2. Mount partitions and create directory for NixOS configuration files

```
sudo mount /dev/disk/by-label/nixos /mnt &&
sudo mkdir -p /mnt/boot /mnt/etc/nixos &&
sudo mount /dev/disk/by-label/boot /mnt/boot
```

3. Download this repository as a ZIP archive and extract its content in /mnt/etc/nixos/dotfiles
   (with `-L`, `curl` follows redirects)

```
cd /mnt/etc/nixos &&
sudo curl -L https://github.com/dmarcoux/dotfiles/archive/refs/heads/main.zip --output dotfiles.zip &&
sudo unzip dotfiles.zip &&
sudo mv dotfiles-main dotfiles
```

4. Find and comment out the various `secrets` imports in the root `home-manager` and `NixOS` Nix files
(Secrets cannot be decrypted since GPG keys are not installed)

```
grep -rni "secrets" *
```

5. Symlink one of the host configurations to `/mnt/etc/nixos/configuration.nix`

```
sudo rm /mnt/etc/nixos/configuration.nix &&
sudo ln --symbolic /mnt/etc/nixos/dotfiles/hosts/CHOOSE_HOST/configuration.nix /mnt/etc/nixos/configuration.nix
```

6. Install NixOS

```
sudo nixos-install
```

7. Reboot

```
reboot
```

-----

1. Log in as `root` with the password set in the NixOS installation

2. Open a terminal and set password for my user

```
passwd dany
```

3. Log out

```
logout
```

4. Log in as my user

5. Set my GPG and SSH keys with `restore-backup-keys` script

6. Clone the dotfiles repository

```
git clone git@github.com:dmarcoux/dotfiles.git ~/dotfiles
```

7. Setup `secrets` gitsubmodule

```
cd dotfiles &&
git submodule init &&
git submodule update &&
cd secrets &&
echo "Follow instructions from the Setup section in secrets' README"
```

8. Symlink one of the host configurations to `/etc/nixos/configuration.nix` (the
default path to the main NixOS configuration module). Create one if not already
done. The generated hardware-configuration.nix is under /etc/nixos.

```
sudo rm /etc/nixos/configuration.nix &&
sudo ln --symbolic "/home/dany/dotfiles/hosts/CHOOSE_HOST/configuration.nix" /etc/nixos/configuration.nix
```

9. Build the NixOS system

```
sudo nixos-rebuild boot
```

10. Reboot

```
reboot
```

11. Clean up `/etc/nixos` to remove everything but `/etc/nixos/configuration.nix`

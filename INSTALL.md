### Install From Scratch on a NixOS System

Set [partitions and filesystems](https://nixos.org/nixos/manual/index.html#sec-installation-partitioning)

Download this repository as a ZIP archive and extract its content in /mnt/etc/nixos/dotfiles

```
cd /mnt/etc/nixos
# With -L, curl follows redirects
sudo curl -L https://github.com/dmarcoux/dotfiles/archive/refs/heads/main.zip --output dotfiles.zip
sudo unzip dotfiles.zip
sudo mv dotfiles-main dotfiles
```

Remove the various `secrets` imports in the root `home-manager` and `NixOS` Nix files
(Secrets cannot be decrypted since GPG keys are not installed)

Symlink one of the host configurations to `/mnt/etc/nixos/configuration.nix`

```
cd /mnt/etc/nixos
sudo rm configuration.nix
sudo ln --symbolic dotfiles/hosts/CHOOSE_HOST/configuration.nix configuration.nix
```

Add [home-manager](https://github.com/nix-community/home-manager) Nix channel

```
# Example of a value for VERSION_NUMBER: 23.05
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-VERSION_NUMBER.tar.gz home-manager
```

Add [nixos-hardware](https://github.com/NixOS/nixos-hardware) Nix channel

```
sudo nix-channel --add https://github.com/NixOS/nixos-hardware/archive/master.tar.gz nixos-hardware
```

Update Nix channels

```
sudo nix-channel --update
```

Install NixOS

```
sudo nixos-install
```

Set password for my user

```
sudo passwd dany
```

Reboot

Set my GPG and SSH keys with `restore-backup-keys` script

Clone the dotfiles repository

```
git clone git@github.com:dmarcoux/dotfiles.git ~/dotfiles
```

Setup `secrets` gitsubmodule

```
cd dotfiles
git submodule init
git submodule update
cd secrets
# See following instructions in secrets' README in the `Setup` section
```

Add [home-manager](https://github.com/nix-community/home-manager) Nix channel

```
# Example of a value for VERSION_NUMBER: 23.05
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-VERSION_NUMBER.tar.gz home-manager
```

Add [nixos-hardware](https://github.com/NixOS/nixos-hardware) Nix channel

```
sudo nix-channel --add https://github.com/NixOS/nixos-hardware/archive/master.tar.gz nixos-hardware
```

Update Nix channels

```
sudo nix-channel --update
```

Go to the dotfiles directory

```
cd ~/dotfiles
```

Symlink one of the host configurations to `/etc/nixos/configuration.nix` (the
default path to the main NixOS configuration module). Create one if not already
done. The generated hardware-configuration.nix is under /etc/nixos.

```
sudo ln --symbolic "$PWD/hosts/CHOOSE_HOST/configuration.nix" /etc/nixos/configuration.nix
```

Build the NixOS system, then reboot

```
sudo nixos-rebuild boot
reboot
```

Clean up /etc/nixos to remove everything but /etc/nixos/configuration.nix

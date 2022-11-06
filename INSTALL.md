### Install From Scratch on a New NixOS System

Set [partitions and filesystems](https://nixos.org/nixos/manual/index.html#sec-installation-partitioning)

Generate the initial NixOS configuration

```
sudo nixos-generate-config --root /mnt
```

Download this repository as a ZIP archive

Extract the ZIP archive in /mnt/etc/nixos/dotfiles

Remove the various `secrets` imports in the root `home-manager` and `NixOS` Nix files
(Secrets cannot be decrypted since GPG keys are not installed)

Symlink one of the host configurations to `/mnt/etc/nixos/configuration.nix`

```
sudo ln --symbolic "$PWD/hosts/CHOOSE_HOST/configuration.nix" /mnt/etc/nixos/configuration.nix
```

Add home-manager Nix channel

```
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-VERSION_NUMBER.tar.gz home-manager
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
git submodule init
git submodule update
cd secrets
# See following instructions in secrets' README in the `Setup` section
```

Add home-manager Nix channel

```
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-VERSION_NUMBER.tar.gz home-manager
sudo nix-channel --update
```

### Install on an Existing NixOS System

Clone the dotfiles repository

```
git clone http://github.com/dmarcoux/dotfiles ~/dotfiles
```

Go to the dotfiles directory

```
cd ~/dotfiles
```

Symlink one of the host configurations to `/etc/nixos/configuration.nix` (the
default path to the main NixOS configuration module)

```
sudo ln --symbolic "$PWD/hosts/laptop/configuration.nix" /etc/nixos/configuration.nix
```

Add home-manager Nix channel

```
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-VERSION_NUMBER.tar.gz home-manager
sudo nix-channel --update
```

Setup `secrets` gitsubmodule

```
git submodule init
git submodule update
cd secrets
# See following instructions in secrets' README in the `Setup` section
```

Build the NixOS system

```
sudo nixos-rebuild switch
```

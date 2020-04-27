# <a href="https://github.com/dmarcoux/dotfiles-nixos">dmarcoux/dotfiles-nixos</a>

I decided to create this repo to backup my dotfiles, but also to share what I
use. Sharing my dotfiles is important to me as it is a way to give back to the
community. I was inspired by a few repos on GitHub and it helped me tremendously
in my quest to fine-tune my setup. I use Linux, more specifically NixOS, so
be aware that I haven't used my dotfiles on another OS or Linux distribution.

### Quick Install

Go to your home directory

`cd`

Clone the repo

`git clone http://github.com/dmarcoux/dotfiles-nixos dotfiles`

Go to the dotfiles directory

`cd dotfiles`

Symlink one of the host configurations to `/etc/nixos/configuration.nix` (the
default path to the main NixOS configuration module)

`sudo ln --symbolic "$PWD/hosts/laptop/configuration.nix" /etc/nixos/configuration.nix`

Build the NixOS system

`sudo nixos-rebuild switch`

### Explanations

This repository is structured as follow:

- *home-manager*: User configuration with
  [home-manager](https://github.com/rycee/home-manager)

- *hosts*: Host specific configuration

- *nixos*: System configuration which applies to all users and hosts

- *scripts*: Various scripts to have in $PATH through a symlink (`ln --symbolic "$PWD/scripts" "$HOME/bin"`)

### Credits

The blog post [Migration to NixOS](https://www.malloc47.com/migrating-to-nixos/)
really helped me in understanding how to setup NixOS and especially
[home-manager](https://github.com/rycee/home-manager).

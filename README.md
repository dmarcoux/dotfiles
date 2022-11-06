# <a href="https://github.com/dmarcoux/dotfiles">dmarcoux/dotfiles</a>

I decided to create this repo to backup my dotfiles, but also to share what I
use. Sharing my dotfiles is important to me as it is a way to give back to the
community. I was inspired by a few repos on GitHub and it helped me tremendously
in my quest to fine-tune my setup. I use Linux, more specifically NixOS, so
be aware that I haven't used my dotfiles on another OS or Linux distribution.

### Explanations

This repository is structured as follow:

- *home-manager*: User configuration with
  [home-manager](https://github.com/nix-community/home-manager)

- *hosts*: Host specific configuration

- *nixos*: System configuration which applies to all users and hosts

### Install From Scratch on a New NixOS System

Refer to [INSTALL.md](INSTALL.md).

### How to Update to a New NixOS Version

Refer to [UPDATE.md](UPDATE.md).

### Credits

The blog post [Migration to NixOS](https://www.malloc47.com/migrating-to-nixos/)
really helped me in understanding how to setup NixOS and especially
[home-manager](https://github.com/nix-community/home-manager).

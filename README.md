# <a href="https://github.com/dmarcoux/dotfiles">dmarcoux/dotfiles</a>

I decided to create this repository to backup my dotfiles, but also to share
what I use. It's a way to give back to the community, since I was inspired by a
few repositories on GitHub and it helped me tremendously in fine-tuning my
setup. I use Linux, more specifically NixOS, so be aware that I haven't used my
dotfiles on another OS or Linux distribution.

### Explanations

This repository is structured as follow:

- *home-manager*: User configuration with
  [home-manager](https://github.com/nix-community/home-manager)

- *hosts*: Host specific configuration

- *nixos*: System configuration which applies to all users and hosts

### Install NixOS on a New Host

Refer to [NEW_INSTALL.md](NEW_INSTALL.md).

### Reinstall NixOS on a Configured Host

Refer to [REINSTALL.md](REINSTALL.md).

### How to Update to a New NixOS Version

Refer to [UPDATE.md](UPDATE.md).

### Credits

The blog post [Migration to NixOS](https://www.malloc47.com/migrating-to-nixos/)
really helped me in understanding how to setup NixOS and especially
[home-manager](https://github.com/nix-community/home-manager).

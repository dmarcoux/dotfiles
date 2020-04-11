# <a href="https://github.com/dmarcoux/dotfiles-nixos">dmarcoux/dotfiles-nixos</a>

I decided to create this repo to backup my dotfiles, but also to share what I
use. Sharing my dotfiles is important to me as it is a way to give back to the
community. I was inspired by a few repos on GitHub and it helped me tremendously
in my quest to fine-tune my setup. I use Linux, more specifically NixOS, so
be aware that I haven't used my dotfiles on another OS or Linux distribution.

### Explanations

I use GNU Stow to manage my dotfiles as it is simple to use and keeps my home
directory clean without any git files. To understand how to use GNU Stow, I
recommend you to read the link *Using GNU Stow to manage your dotfiles* from the
**Credits** section below.

### Quick Install

Go to your home directory

`cd`

Clone the repo

`git clone http://github.com/dmarcoux/dotfiles-nixos`

Go to the dotfiles directory

`cd dotfiles`

Install *xyz* in $HOME (for example, vim)

`stow vim`

Uninstall *xyz* from $HOME (for example, vim)

`stow -D vim`

Install *abc* in a specific directory (for example, *etc* in the directory `/`)

`sudo stow -t / etc`

Uninstall *abc* from a specific directory (for example, *etc* from the directory
`/`)

`sudo stow -D etc -t /`

### Credits

Bits and chunks of my config files come from these sources. Thanks to the people
behind them!

- [Using GNU Stow to manage your
  dotfiles](http://brandon.invergo.net/news/2012-05-26-using-gnu-stow-to-manage-your-dotfiles.html)
- [zsh](https://github.com/xero/dotfiles) and [GNU Stow
  usage](https://github.com/xero/dotfiles/issues/6)
- [.Xresources](https://www.reddit.com/r/archlinux/comments/40w3ld/why_is_font_rendering_so_crap_by_default/cyxlida)

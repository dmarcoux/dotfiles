# home-manager configuration for my desktop computer

{
  home-manager.users.dany.imports = [
    # home-manager base configuration
    ../../home-manager/home.nix
    # Everything else... this list is adapted to this host
    ../../home-manager/alacritty.nix
    ../../home-manager/autorandr.nix
    ../../home-manager/awscli.nix
    ../../home-manager/bat.nix
    ../../home-manager/beets.nix
    ../../home-manager/caffeine.nix
    ../../home-manager/cbatticon.nix
    ../../home-manager/direnv.nix
    # TODO: Commented out since Mise with distrobox doesn't work, at least not with shims.
    #       It's annoying to always have to do `mise exec ...` on the NixOS host
    # ../../home-manager/distrobox.nix
    ../../home-manager/eza.nix
    ../../home-manager/fd.nix
    ../../home-manager/firefox.nix
    ../../home-manager/flameshot.nix
    ../../home-manager/fzf.nix
    ../../home-manager/git.nix
    ../../home-manager/gtk.nix
    ../../home-manager/i3.nix
    ../../home-manager/i3status-rust.nix
    ../../home-manager/jq.nix
    ../../home-manager/keyboard.nix
    ../../home-manager/lf.nix
    ../../home-manager/mise.nix
    ../../home-manager/neovim.nix
    ../../home-manager/network-manager.nix
    ../../home-manager/pasystray.nix
    ../../home-manager/picom.nix
    ../../home-manager/playerctl.nix
    ../../home-manager/redshift.nix
    ../../home-manager/ripgrep.nix
    ../../home-manager/rofi.nix
    ../../home-manager/ruby.nix
    ../../home-manager/ssh.nix
    ../../home-manager/starship.nix
    ../../home-manager/stylix.nix
    ../../home-manager/tldr.nix
    ../../home-manager/udiskie.nix
    ../../home-manager/xdg.nix
    ../../home-manager/xorg.nix
    ../../home-manager/yank.nix
    ../../home-manager/yt-dlp.nix
    ../../home-manager/zellij.nix
    ../../home-manager/zsh.nix
  ];
}

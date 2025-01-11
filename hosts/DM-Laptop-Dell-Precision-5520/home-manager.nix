# home-manager configuration for my Dell Precision 5520 laptop

{
  home-manager.users.dany.imports = [
    # home-manager base configuration
    ../../home-manager/home.nix
    # Everything else... this list is adapted to this host
    ../../home-manager/alacritty.nix
    ../../home-manager/awscli.nix
    ../../home-manager/bat.nix
    ../../home-manager/beets.nix
    ../../home-manager/caffeine.nix
    ../../home-manager/direnv.nix
    ../../home-manager/dotnet.nix
    ../../home-manager/elixir.nix
    ../../home-manager/eza.nix
    ../../home-manager/fd.nix
    ../../home-manager/firefox.nix
    ../../home-manager/flameshot.nix
    ../../home-manager/fzf.nix
    ../../home-manager/git.nix
    ../../home-manager/gtk.nix
    ../../home-manager/jq.nix
    ../../home-manager/keyboard.nix
    ../../home-manager/lf.nix
    ../../home-manager/neovim.nix
    ../../home-manager/playerctl.nix
    ../../home-manager/ripgrep.nix
    ../../home-manager/rofi.nix
    ../../home-manager/ruby.nix
    ../../home-manager/ssh.nix
    ../../home-manager/starship.nix
    ../../home-manager/tldr.nix
    ../../home-manager/xcape.nix
    ../../home-manager/xdg.nix
    ../../home-manager/xorg.nix
    ../../home-manager/yank.nix
    ../../home-manager/yt-dlp.nix
    ../../home-manager/zellij.nix
    ../../home-manager/zsh.nix
  ];
}

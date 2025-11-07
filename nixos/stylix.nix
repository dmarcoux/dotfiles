{ pkgs, pkgs-unstable, ... }:

{
  stylix = {
    enable = true;

    # TODO: Match the theme
    # Credits go to https://github.com/helpotters/dracula-wallpapers
    image = ./stylix-wallpaper.png;

    # High-constrast themes from https://github.com/tinted-theming/schemes
    # Preview them at https://tinted-theming.github.io/base16-gallery/
    #   light
    #   - solarized-light
    #   - measured-light
    #   - precious-light-white
    #   dark
    #   - dracula,
    #   - bright
    #   - da-one-black
    #   - blueforest
    base16Scheme = "${pkgs-unstable.base16-schemes}/share/themes/precious-light-white.yaml";

    fonts = {
      sizes = {
        applications = 12;
        desktop = 10;
        popups = 10;
        terminal = 12;
      };

      monospace = {
        package = pkgs.nerd-fonts.dejavu-sans-mono;
        name = "DejaVuSansM Nerd Font";
      };
    };

    cursor = {
      # https://github.com/ful1e5/Bibata_Cursor
      package = pkgs.bibata-cursors;
      name = "Bibata-Original-Ice"; # For dark themes: Bibata-Original-Classic
      size = 24;
    };
  };

  # TODO: Set LS_COLORS - See https://github.com/danth/stylix/issues/560
  # environment.variables = {
  #   LS_COLORS = ''"${generateLsColors config.lib.stylix.colors}"'';
  # };
}

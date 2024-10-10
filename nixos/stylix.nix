{ pkgs, ... }:

{
  stylix = {
    enable = true;

    # TODO: Match the theme
    # Credits go to https://github.com/helpotters/dracula-wallpapers
    image = ./stylix-wallpaper.png;

    # Preview the themes at https://tinted-theming.github.io/base16-gallery/
    # The themes are at https://github.com/tinted-theming/schemes
    # TODO: Choose between one of those themes:
    #   light
    #   - solarized-light
    #   - measured-light
    #   dark
    #   - dracula,
    #   - bright
    #   - da-one-black
    #   - blueforest
    base16Scheme = "${pkgs.base16-schemes}/share/themes/solarized-light.yaml";

    fonts = {
      sizes = {
        applications = 12;
        desktop = 10;
        popups = 10;
        terminal = 12;
      };

      monospace = {
        package = pkgs.nerdfonts;
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

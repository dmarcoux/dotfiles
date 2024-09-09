{ pkgs, ... }:

{
  stylix = {
    # TODO: Finish setting up stylix
    enable = false;

    # An image is mandatory, but I don't need one for now... so I have a white 1x1 pixel as a placeholder
    image = ./stylix-wallpaper-placeholder.jpg;

    base16Scheme = "${pkgs.base16-schemes}/share/themes/dracula.yaml";
  };
}

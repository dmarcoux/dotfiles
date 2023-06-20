# User configuration for helix

{ pkgs, ... }:

{
  programs.helix = {
    # Install helix
    enable = true;

    # Configure helix
    settings = {
      theme = "solarized_light";

      editor = {
        # Highlight all lines and columns with a cursor (there can be multiple cursors in Helix)
        cursorline = true;
        cursorcolumn = true;
        # Set cursor shape to a bar in normal mode (the default is a block)
        cursor-shape.normal = "bar";
        # Display LSP progress messages below statusline
        lsp.display-messages = true;
        # Number of lines of padding around the edge of the screen when scrolling
        scrolloff = 10;
      };
    };
  };
}

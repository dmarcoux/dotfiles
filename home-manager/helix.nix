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
        # Set cursor shape for the various modes
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        # Configure file picker
        file-picker = {
          # Show hidden files (those starting with a dot) in the file picker
          hidden = false;
          # Do not ignore symlinks that point at files already shown in the file picker
          deduplicate-links = false;
        };
        # Display LSP progress messages below statusline
        lsp.display-messages = true;
        # Number of lines of padding around the edge of the screen when scrolling
        scrolloff = 10;
        # Configure statusline
        statusline = {
          # Display modes with full names, instead of NOR, INS and SEL
          mode.normal = "NORMAL";
          mode.insert = "INSERT";
          mode.select = "SELECT";
        };
        # Display tabs as >·
        # TODO: Also display trailing whitespaces as ·, see https://github.com/helix-editor/helix/issues/2719
        whitespace.render.tab = "all";
        whitespace.characters.tab = ">";
        whitespace.characters.tabpad = "·";          
      };

      # Configure extra keymaps
      keys = {
        # For the insert mode
        insert = {
        };
        # For the normal mode
        normal = {
          # Hard-wrap the current selection of lines to a given width, it differs based on the context
          g.q = ":reflow";
        };
        # For the select mode
        select = {
          # Hard-wrap the current selection of lines to a given width, it differs based on the context
          g.q = ":reflow";
        };
      };
    };
  };
}

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
        # Display LSP progress messages below statusline
        lsp.display-messages = true;
      };
    };
  };
}

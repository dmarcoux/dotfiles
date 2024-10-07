{ pkgs, ... }:

{
  programs.nixvim = {
    # Remove trailing whitespaces only on changed lines
    # https://github.com/tweekmonster/wstrip.vim
    extraPlugins = [ pkgs.vimPlugins.wstrip-vim ];

    # Enable wstrip-vim on all filetypes to remove trailing whitespaces only on changed lines
    # It's useful in rare occasions to disable this in a buffer, do it with the Neovim command `:let b:wstrip_auto = 0`
    globals.wstrip_auto = 1;
  };
}

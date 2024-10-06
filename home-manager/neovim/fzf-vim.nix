{ pkgs, config, ... }:

{
  programs.nixvim = {
    # Use fzf inside vim to open files and much more
    # https://github.com/junegunn/fzf.vim
    extraPlugins = [ pkgs.vimPlugins.fzf-vim ];

    keymaps = [
      # Non-recursive mapping in Normal and Visual modes for Ctrl+p to start fzf for files
      { mode = [ "n" "v" ]; key = "<C-p>"; action = ":Files<CR>"; }
      # Non-recursive mapping in Normal and Visual modes for Ctrl+n to start fzf for buffers
      { mode = [ "n" "v" ]; key = "<C-n>"; action = ":Buffers<CR>"; }
    ];

    extraConfigLua = ''
      -- Display the fzf window at the bottom of the screen with 40% of the available height
      vim.g.fzf_layout = { down = '40%' }
    '';
  };
}

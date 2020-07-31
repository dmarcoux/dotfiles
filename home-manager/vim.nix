# User configuration for vim

{ unstable, ... }:

{
  home.file.".vim/coc-settings.json".text = ''
    {
      "rust-analyzer.serverPath": "${unstable.rust-analyzer}/bin/rust-analyzer"
    }
  '';
}

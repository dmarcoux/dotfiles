{
  programs.zsh.initContent = ''
    if [[ $TERM != "dumb" ]]; then
      # ~/.local/bin/ is needed since the binary is from Distrobox
      eval "$(~/.local/bin/mise activate --shims zsh)"
    fi
  '';
}

# User configuration for jq

{
  # Install jq
  programs.jq.enable = true;

  # Aliases
  programs.zsh.initContent = ''
    # Use a here string to pass some input directly to jq without having to work with a file
    # https://stackoverflow.com/questions/47105490/can-i-pass-a-string-variable-to-jq-not-the-file
    ealias jqs='jq <<<'
  '';
}

{
  programs.zsh.initContent = ''
    # Pretty print / Parse XML (so like jq, but for XML...)
    xq() {
      if [ -z "$1" ]; then
        # Display usage
        echo "Usage: ''${funcstack[1]} 'some string containing XML'"
        return
      fi

      xmllint <(echo "$1")
    }
  '';
}

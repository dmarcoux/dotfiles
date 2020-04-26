# If xmllint is installed, set it up
if type xmllint > /dev/null 2>&1; then
  # Pretty print / Parse XML (so like jq, but for XML...)
  xq() {
    if [ -z "$1" ]; then
      # Display usage
      echo "Usage: ${funcstack[1]} 'some string containing XML'"
      return
    fi

    xmllint <(echo "$1")
  }
fi

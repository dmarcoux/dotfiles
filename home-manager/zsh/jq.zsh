# If jq is installed, set it up
if type jq > /dev/null 2>&1; then
  # Use a here string to pass some input directly to jq without having to work with a file
  # https://stackoverflow.com/questions/47105490/can-i-pass-a-string-variable-to-jq-not-the-file
  ealias jqs='jq <<<'
fi

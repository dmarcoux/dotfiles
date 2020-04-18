# Useful when piped with other commands
alias cbc='xsel --clipboard --input' # Copy to clipboard
alias cbp='xsel --clipboard --output' # Paste from clipboard

# With fzf, select a command from the command history and put it without its numeral part in the clipboard
alias cbcf='fc -rl 1 | fzf --tiebreak=index | sed "s/^ *\([0-9]*\*\?\) *//g" | cbc'

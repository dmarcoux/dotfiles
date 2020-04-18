# --data '{"abc":"123","def":"'my text'"}' or --data @filename (for some file containing JSON)
ealias curljson='curl --verbose --header "Content-Type: application/json" --data' # See above for --data, then add  http://whatever.com

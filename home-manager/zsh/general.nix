{
  programs.zsh.initExtra = ''
    ealias cnf='command-not-found'

    # Quicker than cd ..; cd ...; etc...
    #   ~$ cd ~/dir/example/folder
    #   ~/dir/example/folder$ up 2
    #   ~/dir$
    # Credits: http://www.bashoneliners.com/oneliners/oneliner/220/ (Mostly the same)
    up() {
      # Defaults to 1 when no argument is provided
      VALUE=''${1-1};

      if [[ "$VALUE" = <-> ]]; then
        # The value is a number
        for i in $(seq 1 ''${VALUE}); do
          cd ../
        done
      fi
    }

    # Export environment variables from a file (by default .env, but can be passed as an argument)
    exportenv() {
      FILE=''${1-.env}

      if [ ! -f "$FILE" ]; then
        echo "File $FILE not found"
        return
      fi

      # Read $FILE, remove all commments and empty lines
      VARS="$(cat $FILE | sed -e '/^[[:space:]]*$/d;/^#/d')"

      if [ -z "$VARS" ]; then
        echo "Nothing to export in the file $FILE"
        return
      fi

      echo 'Exporting the environment variables:'
      echo $VARS

      export $(echo $VARS | xargs)
    }

    # Read from STDIN and return matched text
    #
    # $1: regular expression pattern
    #
    # Example: ip link show | sedp 'wlp[0-9]s[0-9]'
    sedp() {
      sed -n "s/^.*\($1\).*$/\1/p"
    }
  '';
}

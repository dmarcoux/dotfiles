{
  programs.zsh.initExtra = ''
    # https://wiki.archlinux.org/index.php/Ranger#Preventing_nested_ranger_instances
    ranger() {
        if [ -z "$RANGER_LEVEL" ]; then
            /usr/bin/env ranger "$@"
        else
            exit
        fi
    }

    ealias ra="ranger"
  '';
}

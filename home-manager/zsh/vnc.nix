{
  programs.zsh.initContent = ''
    # The password file (-rfbauth ~/.vnc/passwd) has to be setup with 'x11vnc -storepasswd'
    ealias vncup='x11vnc -forever -repeat -shared -viewonly -clip xinerama1 -rfbauth ~/.vnc/passwd'
  '';
}

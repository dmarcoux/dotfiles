# User configuration for XDG base directories

{ pkgs, lib, ... }:

{
  home.packages = [ pkgs.xdg-user-dirs ];

  xdg = {
    # Enable management of XDG base directories
    enable = true;
    # Enable management of user directories
    userDirs = {
      # Setup default user directories (Desktop, Documents, Downloads, Music, Pictures, Public, Templates and Videos)
      enable = true;
      # Setup extra user directories
      extraConfig = {
        XDG_AUDIO_DIR = "$HOME/Audio";
        XDG_PROJETS_DIR = "$HOME/Projets";
      };
    };
    # Enable management of XDG MIME applications (so default applications)
    # Desktop files are under /run/current-system/sw/share/applications/
    mimeApps = {
      enable = true;
      defaultApplications = {
        "application/javascript" = "vim.desktop";
        "application/json" = "vim.desktop";
        "application/pdf" = "mupdf.desktop";
        "application/x-desktop" = "vim.desktop";
        "application/x-perl" = "vim.desktop";
        "application/x-shellscript" = "vim.desktop";
        "application/x-zerosize" = "vim.desktop";
        "image/bmp" = "viewnior.desktop";
        "image/gif" = "viewnior.desktop";
        "image/jpeg" = "viewnior.desktop";
        "image/jpg" = "viewnior.desktop";
        "image/pjpeg" = "viewnior.desktop";
        "image/png" = "viewnior.desktop";
        "image/tiff" = "viewnior.desktop";
        "image/x-bmp" = "viewnior.desktop";
        "image/x-pcx" = "viewnior.desktop";
        "image/x-png" = "viewnior.desktop";
        "image/x-portable-anymap" = "viewnior.desktop";
        "image/x-portable-bitmap" = "viewnior.desktop";
        "image/x-portable-graymap" = "viewnior.desktop";
        "image/x-portable-pixmap" = "viewnior.desktop";
        "image/x-tga" = "viewnior.desktop";
        "image/x-xbitmap" = "viewnior.desktop";
        "inode/directory" = "ranger.desktop";
        "text/cache-manifest" = "vim.desktop";
        "text/calendar" = "vim.desktop";
        "text/comma-separated-values" = "vim.desktop";
        "text/css" = "vim.desktop";
        "text/csv" = "vim.desktop";
        "text/directory" = "vim.desktop";
        "text/dns" = "vim.desktop";
        "text/ecmascript" = "vim.desktop";
        "text/english" = "vim.desktop";
        "text/enriched" = "vim.desktop";
        "text/example" = "vim.desktop";
        "text/h323" = "vim.desktop";
        "text/html" = "vim.desktop";
        "text/iuls" = "vim.desktop";
        "text/javascript" = "vim.desktop";
        "text/markdown" = "vim.desktop";
        "text/mathml" = "vim.desktop";
        "text/mml" = "vim.desktop";
        "text/n3" = "vim.desktop";
        "text/parityfec" = "vim.desktop";
        "text/plain" = "vim.desktop";
        "text/prs.fallenstein.rst" = "vim.desktop";
        "text/prs.lines.tag" = "vim.desktop";
        "text/red" = "vim.desktop";
        "text/rfc822-headers" = "vim.desktop";
        "text/richtext" = "vim.desktop";
        "text/rtf" = "vim.desktop";
        "text/rtp-enc-aescm128" = "vim.desktop";
        "text/rtx" = "vim.desktop";
        "text/scriptlet" = "vim.desktop";
        "text/sgml" = "vim.desktop";
        "text/spreadsheet" = "vim.desktop";
        "text/t140" = "vim.desktop";
        "text/tab-separated-values" = "vim.desktop";
        "text/texmacs" = "vim.desktop";
        "text/troff" = "vim.desktop";
        "text/turtle" = "vim.desktop";
        "text/ulpfec" = "vim.desktop";
        "text/uri-list" = "vim.desktop";
        "text/vcard" = "vim.desktop";
        "text/vnd.DMClientScript" = "vim.desktop";
        "text/vnd.IPTC.NITF" = "vim.desktop";
        "text/vnd.IPTC.NewsML" = "vim.desktop";
        "text/vnd.abc" = "vim.desktop";
        "text/vnd.curl.dcurl" = "vim.desktop";
        "text/vnd.curl.mcurl" = "vim.desktop";
        "text/vnd.curl.scurl" = "vim.desktop";
        "text/vnd.curl" = "vim.desktop";
        "text/vnd.dmclientscript" = "vim.desktop";
        "text/vnd.dvb.subtitle" = "vim.desktop";
        "text/vnd.esmertec.theme-descriptor" = "vim.desktop";
        "text/vnd.flatland.3dml" = "vim.desktop";
        "text/vnd.fly" = "vim.desktop";
        "text/vnd.fmi.flexstor" = "vim.desktop";
        "text/vnd.graphviz" = "vim.desktop";
        "text/vnd.in3d.3dml" = "vim.desktop";
        "text/vnd.in3d.spot" = "vim.desktop";
        "text/vnd.iptc.newsml" = "vim.desktop";
        "text/vnd.iptc.nitf" = "vim.desktop";
        "text/vnd.latex-z" = "vim.desktop";
        "text/vnd.motorola.reflex" = "vim.desktop";
        "text/vnd.ms-mediapackage" = "vim.desktop";
        "text/vnd.net2phone.commcenter.command" = "vim.desktop";
        "text/vnd.si.uricatalogue" = "vim.desktop";
        "text/vnd.sun.j2me.app-descriptor" = "vim.desktop";
        "text/vnd.trolltech.linguist" = "vim.desktop";
        "text/vnd.wap.si" = "vim.desktop";
        "text/vnd.wap.sl" = "vim.desktop";
        "text/vnd.wap.wml" = "vim.desktop";
        "text/vnd.wap.wmlscript" = "vim.desktop";
        "text/x-asm" = "vim.desktop";
        "text/x-bibtex" = "vim.desktop";
        "text/x-boo" = "vim.desktop";
        "text/x-c++" = "vim.desktop";
        "text/x-c++hdr" = "vim.desktop";
        "text/x-c++src" = "vim.desktop";
        "text/x-c" = "vim.desktop";
        "text/x-chdr" = "vim.desktop";
        "text/x-comma-separated-values" = "vim.desktop";
        "text/x-component" = "vim.desktop";
        "text/x-crontab" = "vim.desktop";
        "text/x-csh" = "vim.desktop";
        "text/x-csrc" = "vim.desktop";
        "text/x-csv" = "vim.desktop";
        "text/x-diff" = "vim.desktop";
        "text/x-dsrc" = "vim.desktop";
        "text/x-fortran" = "vim.desktop";
        "text/x-haskell" = "vim.desktop";
        "text/x-java-source" = "vim.desktop";
        "text/x-java" = "vim.desktop";
        "text/x-lilypond" = "vim.desktop";
        "text/x-literate-haskell" = "vim.desktop";
        "text/x-makefile" = "vim.desktop";
        "text/x-matlab" = "vim.desktop";
        "text/x-moc" = "vim.desktop";
        "text/x-nfo" = "vim.desktop";
        "text/x-opml" = "vim.desktop";
        "text/x-pascal" = "vim.desktop";
        "text/x-pcs-gcd" = "vim.desktop";
        "text/x-perl" = "vim.desktop";
        "text/x-psp" = "vim.desktop";
        "text/x-python" = "vim.desktop";
        "text/x-scala" = "vim.desktop";
        "text/x-server-parsed-html" = "vim.desktop";
        "text/x-setext" = "vim.desktop";
        "text/x-sfv" = "vim.desktop";
        "text/x-sh" = "vim.desktop";
        "text/x-tcl" = "vim.desktop";
        "text/x-tex" = "vim.desktop";
        "text/x-uuencode" = "vim.desktop";
        "text/x-vcalendar" = "vim.desktop";
        "text/x-vcard" = "vim.desktop";
        "text/xml-external-parsed-entity" = "vim.desktop";
        "text/xml" = "vim.desktop";
      };
    };
  };

  # Generate the user directories defined above with `xdg.userDirs`
  home.activation.xdg-user-dirs-update = lib.hm.dag.entryAfter ["writeBoundary"] ''
    $DRY_RUN_CMD ${pkgs.xdg-user-dirs}/bin/xdg-user-dirs-update
  '';
}

# User configuration for XDG base directories

{ pkgs, config, ... }:

{
  home.packages = [ pkgs.xdg-user-dirs ];

  xdg = {
    # Enable management of XDG base directories
    enable = true;
    # Enable management of XDG user directories
    userDirs = {
      enable = true;

      desktop = "${config.home.homeDirectory}/desktop";
      documents = "${config.home.homeDirectory}/documents";
      download = "${config.home.homeDirectory}/downloads";
      templates = "${config.home.homeDirectory}/templates";
      publicShare = "${config.home.homeDirectory}/public";
      music = "${config.home.homeDirectory}/music";
      pictures = "${config.home.homeDirectory}/pictures";
      videos = "${config.home.homeDirectory}/videos";

      extraConfig = {
        XDG_AUDIO_DIR = "${config.home.homeDirectory}/audio";
        XDG_EBOOKS_DIR = "${config.home.homeDirectory}/ebooks";
        XDG_PROJETS_DIR = "${config.home.homeDirectory}/projets";
        XDG_TEMPORARY_DIR = "${config.home.homeDirectory}/tmp";
      };
    };
    # Enable management of XDG MIME applications (so default applications)
    # Desktop files are under /run/current-system/sw/share/applications/
    # Find the MIME type of a file with `xdg-mime query filetype path/to/file`
    mimeApps = {
      enable = true;
      defaultApplications = {
        "application/javascript" = "nvim.desktop";
        "application/json" = "nvim.desktop";
        "application/pdf" = "org.gnome.Evince.desktop";
        "application/sql" = "nvim.desktop";
        "application/toml" = "nvim.desktop";
        # .odt - Libre Office Writer
        "application/vnd.oasis.opendocument.text" = "writer.desktop";
        # .docx - Libre Office Writer
        "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = "writer.desktop";
        "application/x-desktop" = "nvim.desktop";
        "application/x-perl" = "nvim.desktop";
        "application/x-ruby" = "nvim.desktop";
        "application/x-shellscript" = "nvim.desktop";
        "application/x-yaml" = "nvim.desktop";
        "application/xml" = "nvim.desktop";
        "application/yaml" = "nvim.desktop";
        "application/x-zerosize" = "nvim.desktop";
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
        "inode/directory" = "lf.desktop";
        "inode/x-empty" = "nvim.desktop";
        "text/cache-manifest" = "nvim.desktop";
        "text/calendar" = "nvim.desktop";
        "text/comma-separated-values" = "nvim.desktop";
        "text/css" = "nvim.desktop";
        "text/csv" = "nvim.desktop";
        "text/directory" = "nvim.desktop";
        "text/dns" = "nvim.desktop";
        "text/ecmascript" = "nvim.desktop";
        "text/english" = "nvim.desktop";
        "text/enriched" = "nvim.desktop";
        "text/example" = "nvim.desktop";
        "text/h323" = "nvim.desktop";
        "text/html" = "nvim.desktop";
        "text/iuls" = "nvim.desktop";
        "text/javascript" = "nvim.desktop";
        "text/markdown" = "nvim.desktop";
        "text/mathml" = "nvim.desktop";
        "text/mml" = "nvim.desktop";
        "text/n3" = "nvim.desktop";
        "text/parityfec" = "nvim.desktop";
        "text/plain" = "nvim.desktop";
        "text/prs.fallenstein.rst" = "nvim.desktop";
        "text/prs.lines.tag" = "nvim.desktop";
        "text/red" = "nvim.desktop";
        "text/rust" = "nvim.desktop";
        "text/rfc822-headers" = "nvim.desktop";
        "text/richtext" = "nvim.desktop";
        "text/rtf" = "nvim.desktop";
        "text/rtp-enc-aescm128" = "nvim.desktop";
        "text/rtx" = "nvim.desktop";
        "text/scriptlet" = "nvim.desktop";
        "text/sgml" = "nvim.desktop";
        "text/spreadsheet" = "nvim.desktop";
        "text/t140" = "nvim.desktop";
        "text/tab-separated-values" = "nvim.desktop";
        "text/texmacs" = "nvim.desktop";
        "text/troff" = "nvim.desktop";
        "text/turtle" = "nvim.desktop";
        "text/ulpfec" = "nvim.desktop";
        "text/uri-list" = "nvim.desktop";
        "text/vcard" = "nvim.desktop";
        "text/vnd.DMClientScript" = "nvim.desktop";
        "text/vnd.IPTC.NITF" = "nvim.desktop";
        "text/vnd.IPTC.NewsML" = "nvim.desktop";
        "text/vnd.abc" = "nvim.desktop";
        "text/vnd.curl.dcurl" = "nvim.desktop";
        "text/vnd.curl.mcurl" = "nvim.desktop";
        "text/vnd.curl.scurl" = "nvim.desktop";
        "text/vnd.curl" = "nvim.desktop";
        "text/vnd.dmclientscript" = "nvim.desktop";
        "text/vnd.dvb.subtitle" = "nvim.desktop";
        "text/vnd.esmertec.theme-descriptor" = "nvim.desktop";
        "text/vnd.flatland.3dml" = "nvim.desktop";
        "text/vnd.fly" = "nvim.desktop";
        "text/vnd.fmi.flexstor" = "nvim.desktop";
        "text/vnd.graphviz" = "nvim.desktop";
        "text/vnd.in3d.3dml" = "nvim.desktop";
        "text/vnd.in3d.spot" = "nvim.desktop";
        "text/vnd.iptc.newsml" = "nvim.desktop";
        "text/vnd.iptc.nitf" = "nvim.desktop";
        "text/vnd.latex-z" = "nvim.desktop";
        "text/vnd.motorola.reflex" = "nvim.desktop";
        "text/vnd.ms-mediapackage" = "nvim.desktop";
        "text/vnd.net2phone.commcenter.command" = "nvim.desktop";
        "text/vnd.si.uricatalogue" = "nvim.desktop";
        "text/vnd.sun.j2me.app-descriptor" = "nvim.desktop";
        "text/vnd.trolltech.linguist" = "nvim.desktop";
        "text/vnd.wap.si" = "nvim.desktop";
        "text/vnd.wap.sl" = "nvim.desktop";
        "text/vnd.wap.wml" = "nvim.desktop";
        "text/vnd.wap.wmlscript" = "nvim.desktop";
        "text/x-asm" = "nvim.desktop";
        "text/x-bibtex" = "nvim.desktop";
        "text/x-boo" = "nvim.desktop";
        "text/x-c++" = "nvim.desktop";
        "text/x-c++hdr" = "nvim.desktop";
        "text/x-c++src" = "nvim.desktop";
        "text/x-c" = "nvim.desktop";
        "text/x-chdr" = "nvim.desktop";
        "text/x-comma-separated-values" = "nvim.desktop";
        "text/x-component" = "nvim.desktop";
        "text/x-crontab" = "nvim.desktop";
        "text/x-csh" = "nvim.desktop";
        "text/x-csharp" = "nvim.desktop";
        "text/x-csrc" = "nvim.desktop";
        "text/x-csv" = "nvim.desktop";
        "text/x-diff" = "nvim.desktop";
        "text/x-dsrc" = "nvim.desktop";
        "text/x-elixir" = "nvim.desktop";
        "text/x-fortran" = "nvim.desktop";
        "text/x-go" = "nvim.desktop";
        "text/x-haskell" = "nvim.desktop";
        "text/x-java-source" = "nvim.desktop";
        "text/x-java" = "nvim.desktop";
        "text/x-kotlin" = "nvim.desktop";
        "text/x-lilypond" = "nvim.desktop";
        "text/x-literate-haskell" = "nvim.desktop";
        "text/x-log" = "nvim.desktop";
        "text/x-lua" = "nvim.desktop";
        "text/x-makefile" = "nvim.desktop";
        "text/x-matlab" = "nvim.desktop";
        "text/x-moc" = "nvim.desktop";
        "text/x-nfo" = "nvim.desktop";
        "text/x-opml" = "nvim.desktop";
        "text/x-pascal" = "nvim.desktop";
        "text/x-pcs-gcd" = "nvim.desktop";
        "text/x-perl" = "nvim.desktop";
        "text/x-psp" = "nvim.desktop";
        "text/x-python" = "nvim.desktop";
        "text/x-ruby" = "nvim.desktop";
        "text/x-scala" = "nvim.desktop";
        "text/x-scss" = "nvim.desktop";
        "text/x-server-parsed-html" = "nvim.desktop";
        "text/x-setext" = "nvim.desktop";
        "text/x-sfv" = "nvim.desktop";
        "text/x-sh" = "nvim.desktop";
        "text/x-tcl" = "nvim.desktop";
        "text/x-tex" = "nvim.desktop";
        "text/x-uuencode" = "nvim.desktop";
        "text/x-vcalendar" = "nvim.desktop";
        "text/x-vcard" = "nvim.desktop";
        "text/xml-external-parsed-entity" = "nvim.desktop";
        "text/xml" = "nvim.desktop";
        "x-scheme-handler/slack" = "slack.desktop";
        # TODO: Uncomment and update this if I start using another email client
        # "x-scheme-handler/mailto" = "thunderbird.desktop";
        "x-scheme-handler/https" = "chromium-browser.desktop";
        "x-scheme-handler/http" = "chromium-browser.desktop";
      };
    };
  };
}

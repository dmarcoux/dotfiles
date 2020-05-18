# Setup my email accounts
# NOTE: On the first start, run `notmuch new` to initialize the notmuch's database (it's already setup with the config below, so no need to run `notmuch setup`)

{ pkgs, ... }:

{
  # Synchronize mailboxes with mbsync
  programs.mbsync.enable = true;
  # Send emails with mstmp (it's a SMTP client)
  programs.msmtp.enable = true;
  # Index and search emails with notmuch
  programs.notmuch = {
    enable = true;
    # Fetch emails before indexing them
    hooks.preNew = "mbsync --all";
  };
  # Use the email client Astroid
  programs.astroid = {
    enable = true;
    # Use vim with GUI to write emails (from https://github.com/astroidmail/astroid/wiki/Customizing-editor)
    externalEditor = "vim -g -geom 10x10 --servername %2 --socketid %3 -f -c 'set ft=mail' '+set fileencoding=utf-8' '+set ff=unix' '+set enc=utf-8' '+set fo+=w' %1";
    extraConfig = {
      # Enable and set the interval of automatic mail check
      poll = { interval = 600; }; # seconds, so 10 minutes
    };
    # Index emails with notmuch whenever polling (which itself fetches emails with mbsync)
    pollScript = "notmuch new";
  };

  accounts.email.accounts.personal = {
    primary = true; # Primary email account
    address = "dmarcoux@posteo.de";
    realName = "Dany Marcoux";
    imap.host = "posteo.de";
    smtp.host = "posteo.de";
    # userName and passwordCommand are both for imap and smtp
    userName = "dmarcoux@posteo.de";
    passwordCommand = "pass pass/me/posteo.de=dmarcoux@posteo.de";
    mbsync = {
      enable = true;
      create = "maildir"; # Sync folders from server
    };
    msmtp.enable = true;
    notmuch.enable = true;
    astroid.enable = true;
  };
}

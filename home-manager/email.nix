# Setup my email accounts

{ pkgs, ... }:

{
  # Synchronize mailboxes with mbsync
  programs.mbsync.enable = true;
  # Send emails with mstmp (it's a SMTP client)
  programs.msmtp.enable = true;
  # Use the email client NeoMutt
  programs.neomutt = {
    enable = true;
    # Enable and set the interval of automatic mail check
    checkStatsInterval = 600; # seconds, so 10 minutes
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
    neomutt.enable = true;
  };
}

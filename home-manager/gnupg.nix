# User configuration for GnuPG

{
  programs.gpg.enable = true;

  services.gpg-agent = {
    enable = true;
    enableZshIntegration = true;
    # Use GnuPG agent with SSH support
    enableSshSupport = true;
    # Cache the GPG key for 4 hours
    defaultCacheTtl = 14400; # number of seconds
    # Cache the SSH key for 4 hours
    defaultCacheTtlSsh = 14400; # number of seconds
  };
}

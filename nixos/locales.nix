# System configuration for locales

{
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LANGUAGE = "en_US.UTF-8";
      LC_COLLATE = "en_US.UTF-8";
      LC_CTYPE = "en_US.UTF-8";
      LC_TIME = "fr_CA.UTF-8";
    };
  };

  environment.variables = {
    # From less man-page
    #
    # The LESSCHARSET environment variable may be used to select a character set.
    LESSCHARSET = "utf-8";
  };
}

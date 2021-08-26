# User configuration for firefox

{
  # Set firefox as the default browser
  home.sessionVariables = { BROWSER = "firefox"; };

  programs.firefox = {
    # Install firefox
    enable = true;

    # Setup firefox (settings are from the about:config page in firefox)
    profiles.default.settings = {
      "browser.aboutConfig.showWarning" = false;
      "browser.download.dir" = "/home/dany/downloads";
      "browser.download.folderList" = 2;
      "browser.formfill.enable" = false;
      "browser.search.suggest.enabled" = false;
      "browser.shell.checkDefaultBrowser" = false;
      "browser.startup.homepage" = "about:blank";
      "browser.urlbar.placeholderName" = "DuckDuckGo";
      "browser.urlbar.placeholderName.private" = "DuckDuckGo";
      "browser.urlbar.suggest.history" = false;
      "browser.urlbar.suggest.openpage" = false;
      "extensions.pocket.enabled" = false;
      # Do not autoplay audio and video content on websites
      "media.autoplay.default" = 5;
      # Prevent websites from requesting permission to send desktop notifications
      "permissions.default.desktop-notification" = 2;
    };
  };
}

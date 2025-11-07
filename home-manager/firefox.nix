# User configuration for Firefox

{ config, ... }:

{
  programs.firefox = {
    # Install Firefox
    enable = true;

    # Setup Firefox
    profiles.default = {
      search = {
        # Default search engine - DuckDuckGo
        default = "ddg";
        privateDefault = "ddg";
        # Force replace the existing search configuration. This is recommended since Firefox will replace the symlink for the search configuration on every launch
        force = true;
        # Order in which the search engines are listed. Any engines that aren’t included in this list will be listed after these in an unspecified order
        order = [
          "ddg"
        ];
      };

      # Settings are from the about:config page in Firefox
      settings = {
        # Do not show the warning when opening the `about:config` page
        "browser.aboutConfig.showWarning" = false;
        # Set the default download directory
        "browser.download.dir" = "${config.xdg.userDirs.download}";
        # Remember and suggest the location of the most recent download before downloading a file
        "browser.download.folderList" = 2;
        # Prevent searches for addresses ending with `.home`, those are part of my local network
        # Without this setting, I would have to either always prefix the domain with http:// or https://.
        # Another option would be to always add a slash after the domain, so it would be something.home/, then the search isn't triggered.
        "browser.fixup.domainsuffixwhitelist.home" = true;
        # Do not automatically fill in forms
        "browser.formfill.enable" = false;
        # Disable suggestions in the search bar
        "browser.search.suggest.enabled" = false;
        # Do not check if Firefox is the default browser
        "browser.shell.checkDefaultBrowser" = false;
        # Start Firefox with an empty page
        "browser.startup.homepage" = "about:blank";
        # Disable the Firefox View feature
        "browser.tabs.firefox-view" = false;
        # Do not show the translations popup
        "browser.translations.automaticallyPopup" = false;
        # Do not show the translations feature icon in the address bar
        "browser.translations.panelShown" = false;
        # Set the default text in the address bar to "Search with DuckDuckGo or enter address"
        "browser.urlbar.placeholderName" = "DuckDuckGo";
        # Same as the line above, but for private tabs
        "browser.urlbar.placeholderName.private" = "DuckDuckGo";
        # Do not suggest previously visited pages in the URL bar
        "browser.urlbar.suggest.history" = false;
        # Do not suggest opened tabs in the URL bar
        "browser.urlbar.suggest.openpage" = false;
        # Disable the Pocket feature
        "extensions.pocket.enabled" = false;
        # Do not autoplay audio and video content on websites
        "media.autoplay.default" = 5;
        # Prevent websites from requesting permission to send desktop notifications
        "permissions.default.desktop-notification" = 2;
      };
    };
  };

  # Same profile name as above...
  stylix.targets.firefox.profileNames = [ "default" ];
}

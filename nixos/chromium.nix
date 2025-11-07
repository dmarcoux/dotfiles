# System configuration for chromium

{ pkgs, ... }:

{
  # Set Chromium as the default browser
  environment.sessionVariables = { BROWSER = "chromium"; };

  # Install chromium with WideVine to play DRM-protected content
  environment.systemPackages = [ (pkgs.chromium.override { enableWideVine = true; }) ];

  programs.chromium = {
    # Configure Chromium through policies
    # A list of available policies is available at https://chromeenterprise.google/policies/
    enable = true;
    extraOpts = {
      # Disable the password manager
      "PasswordManagerEnabled" = false;
      # Spellcheck for French, English (American) and German
      "SpellcheckEnabled" = true;
      "SpellcheckLanguage" = [
        "fr"
        "en-US"
        "de"
      ];
      # Spellcheck only through the help of the local dictionaries, not Google
      "SpellCheckServiceEnabled" = false;
      # Disable user profiles
      "BrowserAddPersonEnabled" = false;
      # Disable guest mode
      "BrowserGuestModeEnabled" = false;
      # Restore the last session
      "RestoreOnStartup" = 1;
      # Allow cookies / local data for all websites
      "DefaultCookiesSetting" = 1;
      # Do not import anything
      "ImportAutofillFormData" = false;
      "ImportBookmarks" = false;
      "ImportHistory" = false;
      "ImportHomepage" = false;
      "ImportSavedPasswords" = false;
      "ImportSearchEngine" = false;
      # Do not offer to translate a website
      "TranslateEnabled" = false;
      # Do not automatically play medias
      "AutoplayAllowed" = false;
      # Disable tabs with promotions, user help or requests to set Chromium as the default browser
      "PromotionalTabsEnabled" = false;
      # Always show the bookmark bar
      "BookmarkBarEnabled" = true;
      # Do not save browser history between sessions
      "SavingBrowserHistoryDisabled" = true;
      # On launch, do not check if Chromium is the default browser
      "DefaultBrowserSettingEnabled" = false;
      # Do not autofill address and credit card
      "AutofillAddressEnabled" = false;
      "AutofillCreditCardEnabled" = false;
      # Set DuckDuckGo as the search provider
      # To customize this further, refer to https://duckduckgo.com/duckduckgo-help-pages/settings/params/
      # For other search providers, refer to chrome://settings/searchEngines. It's possible to activate and edit them.
      "DefaultSearchProviderEnabled" = true;
      "DefaultSearchProviderName" = "DuckDuckGo";
      "DefaultSearchProviderSearchURL" = "https://duckduckgo.com/?q={searchTerms}";
      # Disable search suggestions
      "SearchSuggestEnabled" = false;
      # Allow logins to Google account
      "BrowserSignin" = 1;
      # Clear all browser data on exit
      "ClearBrowsingDataOnExitList" = [
        "browsing_history"
        "download_history"
        "cookies_and_other_site_data"
        "cached_images_and_files"
        "password_signin"
        "autofill"
        "site_settings"
        "hosted_app_data"
      ];
      # Disable notifications for all websites
      "DefaultNotificationsSetting" = 2;
    };

    # Install the following extensions
    extensions = [
      # uBlock Origin Lite
      "ddkjiahejlhfcafbddmgiahcphecmpfh"
      # SponsorBlock for YouTube
      "mnjggcdmjocbbbhaepdhchncahnbgone"
      # Privacy Badger
      "pkehgijcmpdhfbdbbnkijodmdjhbjlgp"
      # Unhook for YouTube
      "khncfooichmfjbepaaaebmommgaepoid"
      # linkding extension
      "beakmhbijpdhipnjhnclmhgjlddhidpe"
      # WAVE Evaluation Tool
      "jbbplnpkjmmeebjpijfedlgcdilocofh"
      # 1Password
      "aeblfdkhhhdcdjpifhhbdiojplfjncoa"
    ];
  };
}

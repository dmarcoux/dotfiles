# User configuration for VS Code

{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    # Available extensions: https://github.com/NixOS/nixpkgs/blob/master/pkgs/misc/vscode-extensions/default.nix
    # For other extensions, install with `pkgs.vscode-utils.extensionsFromVscodeMarketplace`
    extensions = pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      # Icons for VS Code
      {
        name = "vscode-icons";
        publisher = "vscode-icons-team";
        version = "10.2.0";
        sha256 = "13s5jrlj2czwh01bi4dds03hd9hpqk1gs9h0gja0g15d0j4kh39c";
      }
      # Spelling Checker
      {
        name = "code-spell-checker";
        publisher = "streetsidesoftware";
        version = "1.9.0";
        sha256 = "0ic0zbv4pja5k4hlixmi6mikk8nzwr8l5w2jigdwx9hc4zhkf713";
      }
      # Vue.js tooling
      {
        name = "vetur";
        publisher = "octref";
        version = "0.28.0";
        sha256 = "01r14f6ynv4pwvi8i9g7hprwhsx6kxjxzs5pqvd9flcvd7kxaks3";
      }
      # Vue.js snippets
      {
        name = "vue-vscode-snippets";
        publisher = "sdras";
        version = "2.1.5";
        sha256 = "0vs0li3106sqw3rpi76cr1mvyyqj0iv8ix6jn84ak2i1gynfh72q";
      }
    ];
    userSettings = {
      "cSpell.language" = "en,fr,de";
      # Automatically rename paired HTML tags
      "editor.renameOnType" = true;
      "editor.renderWhitespace" = "all";
      "editor.tabCompletion" = "on";
      "editor.tabSize" = 2;
      "extensions.autoCheckUpdates" = false;
      "extensions.autoUpdate" = false;
      "extensions.ignoreRecommendations" = true;
      "extensions.showRecommendationsOnlyOnDemand" = true;
      "files.insertFinalNewLine" = true;
      "git.enabled" = true;
      "npm.fetchOnlinePackageInfo" = false;
      "search.quickOpen.includeHistory" = false;
      "search.smartCase" = true;
      "telemetry.enableCrashReporter" = false;
      "telemetry.enableTelemetry" = false;
      "update.mode" = "none";
      "update.showReleaseNotes" = false;
      "vsicons.dontShowNewVersionMessage" = true;
      "workbench.activityBar.visible" = false;
      "workbench.colorTheme" = "Solarized Light";
      "workbench.commandPalette.history" = 0;
      "workbench.editor.enablePreview" = false;
      "workbench.editor.enablePreviewFromQuickOpen" = false;
      "workbench.enableExperiments" = false;
      "workbench.iconTheme" = "vscode-icons";
      "workbench.settings.enableNaturalLanguageSearch" = false;
      "workbench.startupEditor" = "none";
    };
  };
}

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
      # Spell check English, French and German
      "cSpell.language" = "en,fr,de";
      # Do not accept auto-completion suggestions with Enter (if "editor.tabCompletion" is set to "on", it will only be possible with Tab)
      "editor.acceptSuggestionOnEnter" = "off";
      # Automatically rename paired HTML tags
      "editor.renameOnType" = true;
      # Render all whitespace characters
      "editor.renderWhitespace" = "all";
      # Enable tab completion
      "editor.tabCompletion" = "on";
      # Set the number of spaces a tab is equal to
      "editor.tabSize" = 2;
      # Enable Emmet for Vue.js
      "emmet.includeLanguages" = {
        "vue-html" = "html";
      };
      # Do not automatically check extensions for updates
      "extensions.autoCheckUpdates" = false;
      # Do not automatically install updates for extensions
      "extensions.autoUpdate" = false;
      # Do not show notifications for extension recommendations
      "extensions.ignoreRecommendations" = true;
      # Do not fetch extension recommendations
      "extensions.showRecommendationsOnlyOnDemand" = true;
      # Insert a new line at the end of files when saving
      "files.insertFinalNewline" = true;
      # Enable git extension
      "git.enabled" = true;
      # Enable automatic updating of import paths when renaming/moving a file in VS Code
      "javascript.updateImportsOnFileMove.enabled" = "always";
      # Do not fetch data from npm to provide auto-completion and information about npm dependencies
      "npm.fetchOnlinePackageInfo" = false;
      # Do not include recently opened files in the "Quick Open" search
      "search.quickOpen.includeHistory" = false;
      # Show line numbers for search results
      "search.showLineNumbers" = true;
      # Search case-insensitively if the pattern is all lowercase, otherwise, search case-sensitively
      "search.smartCase" = true;
      # Do not send crash reports to Microsoft
      "telemetry.enableCrashReporter" = false;
      # Do not send usage data and errors to Microsoft
      "telemetry.enableTelemetry" = false;
      # Enable automatic updating of import paths when renaming/moving a file in VS Code
      "typescript.updateImportsOnFileMove.enabled" = "always";
      # Do not receive automatic updates
      "update.mode" = "none";
      # Do not show release notes after an update
      "update.showReleaseNotes" = false;
      # Do not show new version messages
      "vsicons.dontShowNewVersionMessage" = true;
      # Hide the activity bar
      "workbench.activityBar.visible" = false;
      # Set the color theme
      "workbench.colorTheme" = "Solarized Light";
      # Disable command history in the command palette
      "workbench.commandPalette.history" = 0;
      # Open files directly without previewing them (previews are reused until opened files are edited)
      "workbench.editor.enablePreview" = false;
      # Open files directly without previewing them in the "Quick Open" search
      "workbench.editor.enablePreviewFromQuickOpen" = false;
      # Do not fetch experiments
      "workbench.enableExperiments" = false;
      # Set the icon theme
      "workbench.iconTheme" = "vscode-icons";
      # Disable the natural language search mode for settings
      "workbench.settings.enableNaturalLanguageSearch" = false;
      # Restore editors from the previous session (if there are any)
      "workbench.startupEditor" = "none";
    };
  };
}

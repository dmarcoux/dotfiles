# User configuration for VS Code

{ pkgs-unstable, config, lib, ... }:

{
  programs.vscode = {
    enable = true;
    # To always have the latest version available on NixOS
    package = pkgs-unstable.vscode;
    # Installing a VS Code extension with NixOS is possible if there's a Nix package for it here: https://github.com/NixOS/nixpkgs/blob/master/pkgs/applications/editors/vscode/extensions/default.nix
    # If not, it's quite cumbersome due to the constantly changing versions and sha256 checksums for frequently updated extensions.
    # In this case, I prefer to install extensions in the command line once, then have them update automatically
    #
    # Install an extension manually with:
    # code --install-extension PUBLISHER.NAME
    #
    # List of extensions to install manually with their identifier, name and description
    # IuriiBarlukov.cursor-column-highlight | Cursor column highlight | Highlights cursor position with vertical line
    extensions = with pkgs-unstable.vscode-extensions; [
      ms-vscode-remote.remote-containers # Devcontainers - https://containers.dev/
      vscodevim.vim # Vim emulation
      streetsidesoftware.code-spell-checker # Spell checking
      bradlc.vscode-tailwindcss # IntelliSense for Tailwind CSS
      vscode-icons-team.vscode-icons # Icons
      ms-python.python # Python: LSP (Pylance), Debugger, and more...
    ];
    keybindings = [
      # Open next editor with "Shift + Right arrow" instead of "Ctrl + Page Down"
      {
        "key" = "shift+right";
        "command" = "workbench.action.nextEditor";
      }
      {
        "key" = "ctrl+pagedown";
        "command" = "-workbench.action.nextEditor";
      }
      # Open previous editor with "Shift + Left arrow" instead of "Ctrl + Page Up"
      {
        "key" = "shift+left";
        "command" = "workbench.action.previousEditor";
      }
      {
        "key" = "ctrl+pageup";
        "command" = "-workbench.action.previousEditor";
      }
      # Unbind "Ctrl + n" (it normally creates a new untitled file)
      {
        "key" = "ctrl+n";
        "command" = "-workbench.action.files.newUntitledFile";
      }
      # Switch to a file (just like buffers in Vim) with "Ctrl + n" (in addition to the default "Ctrl + p")
      {
        "key" = "ctrl+n";
        "command" = "workbench.action.quickOpen";
      }
      # Unbind "Ctrl + Tab" (it normally allows switching to another editor/tab)
      {
        "key" = "ctrl+tab";
        "command" = "-workbench.action.quickOpenPreviousRecentlyUsedEditorInGroup";
      }
      # Unbind "Ctrl + j" (it normally toggle the bottom panel, so displaying the problems/output/terminal)
      {
        "key" = "ctrl+j";
        "command" = "-workbench.action.togglePanel";
      }
      # Toggle the bottom panel, so displaying the problems/output/terminal with "Ctrl + /"
      {
        "key" = "ctrl+/";
        "command" = "workbench.action.togglePanel";
      }
      # Select next auto-completion suggestion with "Ctrl + j"
      {
        "key" = "ctrl+j";
        "command" = "selectNextSuggestion";
        "when" = "suggestWidgetMultipleSuggestions && suggestWidgetVisible && textInputFocus";
      }
      # Select previous auto-completion suggestion with "Ctrl + k"
      {
        "key" = "ctrl+k";
        "command" = "selectPrevSuggestion";
        "when" = "suggestWidgetMultipleSuggestions && suggestWidgetVisible && textInputFocus";
      }
      # Accept selected auto-completion suggestion with "Ctrl + l"
      {
        "key" = "ctrl+l";
        "command" = "acceptSelectedSuggestion";
        "when" = "suggestWidgetVisible && textInputFocus";
      }
      # Select next option in "Quick Open" menu with "Ctrl + j"
      {
        "key" = "ctrl+j";
        "command" = "workbench.action.quickOpenSelectNext";
        "when" = "inQuickOpen";
      }
      # Select previous option in "Quick Open" menu with "Ctrl + k"
      {
        "key" = "ctrl+k";
        "command" = "workbench.action.quickOpenSelectPrevious";
        "when" = "inQuickOpen";
      }
    ];
    userSettings = {
      # Spell check English, French and German
      "cSpell.language" = "en,fr,de";
      # Do not accept auto-completion suggestions with Enter (if "editor.tabCompletion" is set to "on", it will only be possible with Tab)
      "editor.acceptSuggestionOnEnter" = "off";
      # Set the font family
      "editor.fontFamily" = lib.mkForce "'${config.stylix.fonts.monospace.name}'";
      # Do not show indent guides
      "editor.guides.indentation" = false;
      # Update related symbols (like HTML tags) whenever one of them is changed (so changing <a> to <ul> would change the closing tag </a> to </ul>)
      "editor.linkedEditing" = true;
      # Do not show the minimap
      "editor.minimap.enabled" = false;
      # Do not render the last line number when it's an empty newline
      "editor.renderFinalNewline" = "off";
      # Display only trailing whitespace characters
      "editor.renderWhitespace" = "trailing";
      # Enable tab completion and accept auto-completion suggestions with Tab
      "editor.tabCompletion" = "on";
      # Set the number of spaces a tab is equal to
      "editor.tabSize" = 2;
      # Do not automatically check extensions for updates
      "extensions.autoCheckUpdates" = false;
      # Do not automatically install updates for extensions
      "extensions.autoUpdate" = false;
      # Do not show notifications for extension recommendations
      "extensions.ignoreRecommendations" = true;
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
      # Sort entries in the "Quick Open" search by recency. More recently opened entries appear first.
      "search.quickOpen.history.filterSortOrder" = "recency";
      # Show line numbers for search results
      "search.showLineNumbers" = true;
      # Search case-insensitively if the pattern is all lowercase, otherwise, search case-sensitively
      "search.smartCase" = true;
      # Disable telemetry reporting
      "telemetry.telemetryLevel" = "off";
      # Enable automatic updating of import paths when renaming/moving a file in VS Code
      "typescript.updateImportsOnFileMove.enabled" = "always";
      # Do not receive automatic updates
      "update.mode" = "none";
      # Do not show release notes after an update
      "update.showReleaseNotes" = false;
      # Highlight copied/yanked region in red for 1 second
      "vim.highlightedyank.enable" = true;
      "vim.highlightedyank.duration" = 1000; # milliseconds
      "vim.highlightedyank.textColor" = "red";
      # Handle (or not) keys in the vim extension
      "vim.handleKeys" = {
        # Do not handle "Ctrl + w" in the vim extension, it's used in closing tabs/editors in VS Code
        "<C-w>" = false;
        # Do not handle "Ctrl + b" in the vim extension, it's used in hiding the sidebar in VS Code
        "<C-b>" = false;
        # Do not handle "Ctrl + p" in the vim extension, it's used to go to a file in VS Code
        "<C-p>" = false;
      };
      # Highlight matches of last search done in the vim extension
      "vim.hlsearch" = true;
      # Bind the leader key to comma, then use it in keybindings with <leader>
      "vim.leader" = ",";
      "vim.normalModeKeyBindingsNonRecursive" = [
        # Make undo work with the vim extension
        {
          "before" = ["u"];
          "commands" = ["undo"];
        }
        # Make redo work with the vim extension
        {
          #           Ctrl + r
          "before" = ["<C-r>"];
          "commands" = ["redo"];
        }
        # Turn off search highlighting
        {
          "before" = ["<leader>" "<enter>"];
          "commands" = [":nohl"];
        }
      ];
      # Disable vim-surround plugin for vim extension
      "vim.surround" = false;
      # Use system clipboard in vim extension
      "vim.useSystemClipboard" = true;
      # Do not show new version messages
      "vsicons.dontShowNewVersionMessage" = true;
      # Hide the activity bar
      "workbench.activityBar.location" = "hidden";
      # Disable command history in the command palette
      "workbench.commandPalette.history" = 0;
      # Open files directly without previewing them (previews are reused until opened files are edited)
      "workbench.editor.enablePreview" = false;
      # Open files directly without previewing them in the "Quick Open" search
      "workbench.editor.enablePreviewFromQuickOpen" = false;
      # Do not show tabs (one tab is opened whenever opening a file)
      "workbench.editor.showTabs" = "none";
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

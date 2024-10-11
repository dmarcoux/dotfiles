# User configuration for tldr

{ pkgs-unstable, config, ... }:

{
  # Install tlrc, one of the official clients for tldr - Collaborative cheatsheets for console commands (https://tldr.sh/)
  home.packages = [ pkgs-unstable.tlrc ];

  # Configure tlrc
  xdg.configFile."tlrc/config.toml".text = ''
    # Started with configuration example at https://github.com/tldr-pages/tlrc, then adapted to my needs...
    [cache]
    # Override the cache directory.
    dir = "${config.xdg.cacheHome}/tlrc"
    # Override the base URL used for downloading tldr pages.
    # The mirror must provide files with the same names as the official tldr pages repository:
    # mirror/tldr.sha256sums            must point to the SHA256 checksums of all assets
    # mirror/tldr-pages.LANGUAGE.zip    must point to a zip archive that contains platform directories with pages in LANGUAGE
    mirror = "https://github.com/tldr-pages/tldr/releases/latest/download"
    # Do not automatically update the cache
    auto_update = false
    # Specify a list of desired page languages. If it's empty, languages specified in
    # the LANG and LANGUAGE environment variables are downloaded.
    # English is implied and will always be downloaded.
    # You can see a list of language codes here: https://github.com/tldr-pages/tldr
    # Example: ["de", "pl"]
    languages = ["en"]

    [output]
    # Show the title in the rendered page.
    show_title = true
    # Do not show the platform name ('common', 'linux', etc.) in the title.
    platform_title = false
    # Do not prefix descriptions of examples with hyphens.
    show_hyphens = false
    # Do not strip empty lines from output.
    compact = false
    # Do not print pages in raw Markdown.
    raw_markdown = false

    # Number of spaces to put before each line of the page.
    [indent]
    # Command name.
    title = 2
    # Command description.
    description = 2
    # Descriptions of examples.
    bullet = 2
    # Example command invocations.
    example = 4

    # Style for the title of the page (command name).
    [style.title]
    # Fixed colors:       "black", "red", "green", "yellow", "blue", "magenta", "cyan", "white", "default"
    # 256color ANSI code: { color256 = 50 }
    # RGB:                { rgb = [0, 255, 255] }
    color = "white"
    background = "default"
    bold = false
    underline = false
    italic = true
    dim = false
    strikethrough = false

    # Style for the description of the page.
    [style.description]
    color = "blue"
    background = "default"
    bold = false
    underline = false
    italic = false
    dim = false
    strikethrough = false

    # Style for descriptions of examples.
    [style.bullet]
    color = "green"
    background = "default"
    bold = false
    underline = false
    italic = false
    dim = false
    strikethrough = false

    # Style for command examples.
    [style.example]
    color = "white"
    background = "default"
    bold = false
    underline = false
    italic = false
    dim = false
    strikethrough = false

    # Style for URLs inside the description.
    [style.url]
    color = "cyan"
    background = "default"
    bold = false
    underline = true
    italic = true
    dim = false
    strikethrough = false

    # Style for text surrounded by backticks (`).
    [style.inline_code]
    color = "yellow"
    background = "default"
    bold = false
    underline = false
    italic = true
    dim = false
    strikethrough = false

    # Style for placeholders inside command examples.
    [style.placeholder]
    color = "cyan"
    background = "default"
    bold = false
    underline = false
    italic = true
    dim = false
    strikethrough = false
  '';
}

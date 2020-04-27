# User configuration for youtube-dl

{ pkgs, ... }:

{
  # Install youtube-dl
  home.packages = [ pkgs.youtube-dl ];

  # Configure youtube-dl
  xdg.configFile."youtube-dl/config".text = ''
    # Do not overwrite files
    --no-overwrites

    # Add metadata to the video files
    --add-metadata

    # Write video description to a .description file
    --write-description

    # Restrict filenames to only ASCII characters, and avoid "&" and spaces in filenames
    --restrict-filenames

    # Save videos under "~/Videos/WebsiteName/" with the filename "VideoTitle---FormatNote-VideoId.VideoExtension"
    --output "~/Videos/%(extractor_key)s/%(title)s---%(format_note)s-%(id)s.%(ext)s"

    # Select the best audio quality (when extracting audio with -x/--extract-audio)
    --audio-quality 0
  '';

  programs.zsh.shellAliases = {
    # Save music under "~/Music/WebsiteName/" with the filename "MusicTitle---FormatNote-SourceId.AudioExtension"
    audio-dl = "youtube-dl --output '~/Music/%(extractor_key)s/%(title)s---%(format_note)s-%(id)s.%(ext)s' --extract-audio --audio-format mp3";
  };

  programs.zsh.initExtra = ''
    # Download French and German videos from arte.tv
    #
    # $@: arte.tv URL(s) (either French or German)
    arte-dl() {
      # Replace /fr/ or /de/ by {fr,de} in the arte.tv URL(s) (arte.tv handles correctly the switch of locale, even when done directly in their URLs)
      # Pass the URL to xargs which expands {fr,de} (thanks to `sh -c`),
      # then pass the output to youtube-dl (`-I %` positions the output after `youtube-dl`)
      echo "$@" | sed --regexp-extended "s@(/fr/|/de/)@/{fr,de}/@g" | xargs -I % sh -c "youtube-dl %"
    }
  '';
}

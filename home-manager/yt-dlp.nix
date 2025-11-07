# User configuration for yt-dlp

{ pkgs, ... }:

{
  programs.yt-dlp = {
    # Install yt-dlp
    enable = true;

    # Configure yt-dlp
    # Only use `extraConfig` instead of `settings` since it's clearer what the options really are when comments are written in the config file
    extraConfig = ''
      # Do not overwrite files
      --no-overwrites

      # Add metadata to the video files
      --add-metadata

      # Write video description to a .description file
      --write-description

      # Restrict filenames to only ASCII characters, and avoid "&" and spaces in filenames
      --restrict-filenames

      # Select the best audio quality (when extracting audio with -x/--extract-audio)
      --audio-quality 0

      # Save videos under "~/videos/WebsiteName/" with the filename "VideoTitle---FormatNote-VideoId.VideoExtension"
      --output "~/videos/%(extractor_key)s/%(title)s---%(format_note)s-%(id)s.%(ext)s"

      # Download subtitles for English, French and German
      --sub-langs en,fr,de

      # Embed subtitles in the video (only possible with mp4, webm and mkv files)
      --embed-subs

      # Download with the best resolution and if possible, in the video format mp4 and audio format m4a.
      # If the video format isn't mp4 already, it will be converted to mp4
      --format-sort res,ext:mp4:m4a --recode mp4
    '';
  };

  programs.zsh.initContent = ''
    # Download French and German videos from arte.tv
    #
    # $@: arte.tv URL(s) (either French or German)
    arte-dl() {
      # Replace /fr/ or /de/ by {fr,de} in the arte.tv URL(s) (arte.tv handles correctly the switch of locale, even when done directly in their URLs)
      # Pass the URL to xargs which expands {fr,de} (thanks to `sh -c`),
      # then pass the output to yt-dlp (`-I %` positions the output after `yt-dlp`)
      echo "$@" | sed --regexp-extended "s@(/fr/|/de/)@/{fr,de}/@g" | xargs -I % sh -c "yt-dlp %"
    }
  '';
}

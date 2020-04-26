# If youtube-dl is installed, set it up
if type youtube-dl > /dev/null 2>&1; then
  # Save music under "~/Music/WebsiteName/" with the filename "MusicTitle---FormatNote-SourceId.AudioExtension"
  alias audio-dl='youtube-dl --output "~/Music/%(extractor_key)s/%(title)s---%(format_note)s-%(id)s.%(ext)s" --extract-audio --audio-format mp3'

  # Download French and German videos from arte.tv
  #
  # $@: arte.tv URL(s) (either French or German)
  arte-dl() {
    # Replace /fr/ or /de/ by {fr,de} in the arte.tv URL(s) (arte.tv handles correctly the switch of locale, even when done directly in their URLs)
    # Pass the URL to xargs which expands {fr,de} (thanks to `sh -c`),
    # then pass the output to youtube-dl (`-I %` positions the output after `youtube-dl`)
    echo "$@" | sed --regexp-extended "s@(/fr/|/de/)@/{fr,de}/@g" | xargs -I % sh -c "youtube-dl %"
  }
fi

# System configuration for unclutter

{
  # The `unclutter` service with the standard `unclutter` package causes focus to not always travel to the selected window
  # https://github.com/i3/i3/issues/3506
  services.unclutter-xfixes = {
    # Hide mouse cursor when inactive
    enable = true;
    # Number of seconds before the cursor is marked as inactive
    timeout = 10;
  };
}

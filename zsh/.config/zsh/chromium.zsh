# If chromium is installed, set it up
if type chromium > /dev/null 2>&1; then
  # Edit chromium's desktop file to launch chromium by using unencrypted password store (I don't care, I only use it for one unauthenticated webpage since it doesn't work on Firefox)
  if grep -Fxq 'Exec=chromium %u' /usr/share/applications/chromium-browser.desktop; then
    sudo --prompt="[sudo] password for root to change chromium's Exec in chromium-browser.desktop to use unencrypted password store: " sed --in-place 's/Exec=.*/Exec=chromium --password-store=basic %u/' /usr/share/applications/chromium-browser.desktop
  fi
fi

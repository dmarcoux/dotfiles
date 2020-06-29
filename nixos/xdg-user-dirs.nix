# System configuration for xdg-user-dirs

{
  # Enable management of user directories
  # It would be nice if it worked in home-manager, but it doesn't: https://github.com/rycee/home-manager/issues/1159
  environment.etc."xdg/user-dirs.defaults".text = ''
    DESKTOP=desktop
    DOWNLOAD=downloads
    TEMPLATES=templates
    PUBLICSHARE=public
    DOCUMENTS=documents
    MUSIC=music
    PICTURES=pictures
    VIDEOS=videos
    AUDIO=audio
    PROJETS=projets
    TEMPORARY=tmp
  '';
}

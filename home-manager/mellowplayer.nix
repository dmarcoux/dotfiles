# User configuration for MellowPlayer

{ pkgs, ... }:

{
  # Install MellowPlayer
  home.packages = [ pkgs.mellowplayer ];

  # Configure MellowPlayer
  xdg.configFile."MellowPlayer/MellowPlayer3.conf".text = ''
    [General]
    zoom=1

    [8tracks]
    sortIndex=0

    [Anghami]
    sortIndex=2

    [Apple%20Music]
    sortIndex=3

    [Bandcamp]
    sortIndex=4

    [Brain.fm]
    sortIndex=5

    [ClassicalRadio.com]
    sortIndex=6

    [DI.FM]
    sortIndex=8

    [Deezer]
    sortIndex=7

    [Google%20Play%20Music]
    sortIndex=9

    [HearThisAt]
    sortIndex=10

    [HypeMachine]
    sortIndex=11

    [JAZZRADIO.com]
    sortIndex=13

    [Jamendo]
    sortIndex=12

    [MellowPlayer.Connect]
    sortIndex=15

    [Mixcloud]
    sortIndex=16

    [Netflix]
    sortIndex=17

    [Pandora]
    sortIndex=18

    [Player%20FM]
    sortIndex=19

    [Plex]
    sortIndex=20

    [Pocket%20Casts]
    sortIndex=21

    [ROCKRADIO.com]
    sortIndex=24

    [Radio%20Paradise]
    sortIndex=22

    [RadioTunes]
    sortIndex=23

    [Soundcloud]
    sortIndex=25

    [Spotify]
    sortIndex=26

    [Tidal]
    sortIndex=27

    [TuneIn]
    sortIndex=28

    [Wynk]
    sortIndex=29

    [Yandex%20Music]
    sortIndex=30

    [Youtube]
    sortIndex=32

    [Youtube%20Music]
    sortIndex=33

    [ZenRadio]
    sortIndex=34

    [amazon%20music]
    sortIndex=1

    [magnatune]
    sortIndex=14

    [main]
    check-for-updates=false

    [notifications]
    enabled=false

    [private]
    current-service=Deezer
    show-close-to-tray-message=false
    window-height=1025
    window-width=1916

    [ympd]
    sortIndex=31
  '';
}

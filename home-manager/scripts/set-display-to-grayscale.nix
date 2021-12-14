{ pkgs, ... }:

{
  home.file."bin/set-display-to-grayscale" = {
    executable = true;
    text = ''
      #!/bin/sh
      # Script adapted from https://www.reddit.com/r/archlinux/comments/j2tt7o/how_to_turn_display_grayscale/g79z3ii/

      # Kill all picom processes
      pkill picom

      # Use a file to track grayscale mode
      if grep -q '1' ~/tmp/grayscale; then
          mkdir --parents ~/tmp
          echo 0 > ~/tmp/grayscale
      else
          sleep 0.1

          picom -b  --backend glx --glx-fshader-win "
          uniform sampler2D tex;
          void main() {
               vec4 c = texture2D(tex, gl_TexCoord[0].xy);
               float y = dot(c.rgb, vec3(0.299, 0.587, 0.114));
               gl_FragColor = vec4(y, y, y, 1.0);
         }"

         echo 1 > ~/tmp/grayscale
      fi
    '';
  };
}

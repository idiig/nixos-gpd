{ pkgs, lib, ... }:
let
  wallpaper = builtins.fetchurl {
    url = "https://gitlab.xfce.org/xfce/xfdesktop/-/raw/master/backgrounds/xfce-blue.jpg?inline=false";
    sha256 = "1f7v1q1wkgqjsawvz4dfj9izciid73i11636v5vidbbilvx95vqj";
  };
in
{

  home.activation.setWallpaper = lib.mkBefore ''
    mkdir -p $HOME/.local/share/backgrounds/
    ln -sf ${wallpaper} $HOME/.local/share/backgrounds/default.jpg
  '';

#   home.file.".xsession".source = pkgs.writeTextFile {
#     name = "xsession";
#     text = ''
#       ${pkgs.feh}/bin/feh --bg-fill --no-fehbg $HOME/.local/share/backgrounds/default.jpg > $HOME/feh.log 2>&1
#     '';
#   };

#   home.file.".xinitrc".source = pkgs.writeTextFile {
#     name = "xinitrc";
#     text = ''
#       ${pkgs.feh}/bin/feh --bg-fill --no-fehbg $HOME/.local/share/backgrounds/default.jpg > $HOME/feh.log 2>&1
#     '';
#   };
}


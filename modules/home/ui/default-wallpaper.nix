{ pkgs, ... }:
let
  wallpaper = builtins.fetchurl {
    url = "https://gitlab.xfce.org/xfce/xfdesktop/-/raw/master/backgrounds/xfce-blue.jpg?inline=false";
    sha256 = "1f7v1q1wkgqjsawvz4dfj9izciid73i11636v5vidbbilvx95vqj";
  };
in
{
  home.activation.setWallpaper = ''
    mkdir -p $HOME/.local/share/backgrounds/xfce
    ln -sf ${wallpaper} $HOME/.local/share/backgrounds/xfce/xfce-blue.jpg
    ${pkgs.feh}/bin/feh --bg-fill $HOME/.local/share/backgrounds/xfce/xfce-blue.jpg
  '';
}

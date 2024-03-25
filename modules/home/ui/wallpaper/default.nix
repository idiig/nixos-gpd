# { pkgs, ... }:

# {
#   home.packages = [
#     (pkgs.callPackage ./xfce-blue.nix { })
#   ];
#   home.file.".background-image/xfce-blue.jpg".source = pkgs.fetchurl {
#     url = "https://gitlab.xfce.org/xfce/xfdesktop/-/raw/master/backgrounds/xfce-blue.jpg?inline=false";
#     sha256 = "1f7v1q1wkgqjsawvz4dfj9izciid73i11636v5vidbbilvx95vqj";
#   };

#   home.file.".wallpaper.sh".source = ./.wallpaper.sh;
# }
{ pkgs, ... }:
let
  wallpaper = builtins.fetchurl {
    url = "https://gitlab.xfce.org/xfce/xfdesktop/-/raw/master/backgrounds/xfce-blue.jpg?inline=false";
    sha256 = "1f7v1q1wkgqjsawvz4dfj9izciid73i11636v5vidbbilvx95vqj";
  };
in
{
  home.activation.setWallpaper = ''
    mkdir -p $HOME/.local/share/backgrounds
    ln -sf ${wallpaper} $HOME/.local/share/backgrounds/wallpaper.jpg
    ${pkgs.feh}/bin/feh --bg-fill $HOME/.local/share/backgrounds/wallpaper.jpg
  '';
  # phasestart = "setup";
}

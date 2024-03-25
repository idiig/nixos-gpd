# https://gitlab.xfce.org/xfce/xfdesktop/-/raw/master/backgrounds/xfce-blue.jpg?inline=false

{
  pkgs ? import <nixpkgs> { },
  # lib, ...
}:

pkgs.stdenv.mkDerivation rec {
  
  name = "default-wallpaper";

  buildInputs = with pkgs;[
    feh
  ];

  nativeBuildInputs = [ 
    # some native packages
  ]; 
  
  src = pkgs.fetchurl {
    url = "https://gitlab.xfce.org/xfce/xfdesktop/-/raw/master/backgrounds/xfce-blue.jpg?inline=false";
    sha256 = "1f7v1q1wkgqjsawvz4dfj9izciid73i11636v5vidbbilvx95vqj";
  };
  
  dontUnpack = true;
  
  installPhase = ''
    mkdir -p $out/share/backgrounds
    cp -r ./* $out/share/backgrounds
    # feh --bg-center --no-fehbg $out/share/backgrounds
  '';

}

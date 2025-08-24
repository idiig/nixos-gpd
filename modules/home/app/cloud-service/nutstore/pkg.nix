{
  pkgs ? import <nixpkgs> { },
  # lib, ...
}:


rec {
  nutstore-unwrapped = (pkgs.buildFHSEnv {
    name = "nutstore-unwrapped";
    targetPkgs = pkgs: (with pkgs; [
      udev
      alsa-lib
      zlib
      cairo
      glib
      glib-networking
      webkitgtk

      gtk3
      libnotify
      (python3.withPackages (pythonPackages: with pythonPackages; [
        pygobject3
      ]))
    ]) ++ (with pkgs.xorg; [
      libX11
      libXcursor
      libXrandr
    ]);
    multiPkgs = pkgs: (with pkgs; [
      udev
      glib-networking
      alsa-lib
    ]);
    runScript = ''env GI_TYPELIB_PATH=/usr/lib/girepository-1.0 GIO_MODULE_DIR=${pkgs.glib-networking} python $HOME/.nutstore/dist/bin/nutstore-pydaemon.py'';
  });
  nutstore = pkgs.stdenv.mkDerivation {
    name = "nutstore";
    pname = "0.0.1";

    src = ./.;

    buildInputs = [
      pkgs.makeWrapper
    ];

    installPhase = let 
      desktopEntry = ./nutstore-menu.desktop;
    in ''
      mkdir -p $out/bin $out/share/applications
      makeWrapper ${nutstore-unwrapped}/bin/nutstore-unwrapped $out/bin/nutstore
      sed "s,Exec=.*,Exec=$out/bin/nutstore,; s,Icon=.*,Icon=${./share/icons/hicolor/512x512/apps/nutstore.png}," ${desktopEntry} > $out/share/applications/nutstore-menu.desktop
    '';
  };
  
  default = nutstore;
}

{
  pkgs ? import <nixpkgs> { },
  # lib, ...
}:

pkgs.stdenv.mkDerivation rec {
  
  name = "autokey-emacs-config";

  buildInputs = with pkgs;[
    # some packages
  ];

  nativeBuildInputs = [ 
    # some native packages
  ]; 

  src = pkgs.fetchFromGitHub {
    owner = "idiig";
    repo = "autokey-emacs-config";
    rev = "master";  # branch name or version name
    sha256 = "sha256-+N/t9QgC4U03EkxOLwv+hiqHceGFNlxgo27VNbppiKA=";
  };
 
  installPhase = ''
    mkdir -p $out/share/autokey/emacs
    cp -r ./* $out/share/autokey/emacs
  '';

}



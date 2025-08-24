{
  pkgs ? import <nixpkgs> { },
  # lib, ...
}:

pkgs.stdenv.mkDerivation rec {
  
  name = "Haiku";
  # pname = "Haiku";
  # version = "0.1";

  buildInputs = with pkgs;[
    # some packages
  ];

  nativeBuildInputs = [ 
    # some native packages
  ]; 

  src = pkgs.fetchFromGitHub {
    owner = "idiig";
    repo = "Haiku";
    rev = "master";  # branch name or version name
    sha256 = "sha256-IrMomBJoPBrj0CKzDP4z2ZdQI+Bnm8Lox0wFFvXbDrE="; # 使用nix-prefetch-github或nix-prefetch-url获取实际的sha256值
  };

  installPhase = ''
    mkdir -p $out/share/themes/Haiku
    cp -r ./* $out/share/themes/Haiku
  '';

  # meta = with lib; {
  #   description = "Your theme description";
  #   homepage = "https://github.com/B00merang-Project/Haiku";
  #   license = licenses.gpl3;
  # };

}


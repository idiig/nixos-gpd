
{
  pkgs ? import <nixpkgs> { },
  # lib, ...
}:

pkgs.stdenv.mkDerivation rec {
  
  name = "Multiload-ng";
  # pname = "Haiku";
  # version = "0.1";

  buildInputs = with pkgs;[
    # some packages
    gtk2 gtk3 ncurses glib pkg-config xfce.xfce4-dev-tools  # libxfce4panel
    xfce.libxfce4util xfce.libxfce4ui xfce.exo xfce.xfce4-panel
  ];

  nativeBuildInputs = [ 
    # some native packages
  ]; 

  src = pkgs.fetchFromGitHub {
    owner = "idiig";
    repo = "Multiload-ng";
    rev = "743885da84474bfffc5f5505c0d1a7160de6afef";  # branch name or version name
    sha256 = "sha256-AMjbNXK0NeRz7cfzn7kCkY6zllrVXBqB44FMics5xOw="; # 使用nix-prefetch-github或nix-prefetch-url获取实际的sha256值
  };

  installPhase = ''
    ./autogen.sh
    make clean
    ./configure --prefix=$out --with-xfce4
    chmod +x ./data/generate-about-data.sh
    chmod +x ./generate-about-data.sh
    make
    sudo make install
  '';

}


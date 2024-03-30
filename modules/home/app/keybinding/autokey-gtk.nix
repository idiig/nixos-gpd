{ pkgs, ... }:

let
  keybinding = pkgs.fetchFromGitHub {
    owner = "idiig";
    repo = "autokey-emacs-config";
    rev = "master";  # branch name or version name
    sha256 = "sha256-+N/t9QgC4U03EkxOLwv+hiqHceGFNlxgo27VNbppiKA=";
  };
in
 
{
  home.packages = with pkgs; [ 
    autokey 
    # (callPackage ./autokey/emacs-like-keybinding.nix { })
  ];

  home.activation.setKeybinding = ''
    mkdir -p $HOME/.config/autokey/
    ln -sf ${keybinding} $HOME/.config/autokey/
  '';

  # home.file."/config/aotokey".source = $HOME/share/autokey/emacs;
}

{ pkgs, ... }:

let
  myVars = import ../../myvars/gpd-pocket-3-idiig.nix;
in 

{
  imports = [

    # better-default
    # ./app/better-default/..

    # editors
    ./app/editor/emacs.nix
    ./app/editor/vim.nix

    # security-privacy
    ./app/security-privacy/ssh.nix
    ./app/security-privacy/gnupg.nix

    # version-management
    ./app/version-management/git.nix

    # browser
    ./app/browser/firefox.nix

    # image-processor
    ./app/image-processor/evince.nix
    ./app/image-processor/inkscape.nix 
    
    # shell
    ./app/shell/zsh.nix

    # word processor software
    ./app/word-processor/libreoffice.nix

    # cloud-service
    ./app/cloud-service/nutstore/nutstore.nix
    ./app/cloud-service/dropbox.nix
    # (pkgs.callPackage ./gtk-themes/haiku.nix { })
  
    # reference-management
    ./app/reference-management/zotero.nix

    # terminal
    ./app/terminal/alacritty.nix
  
    # UI
    ./ui/gtk.nix
    ./ui/default-wallpaper.nix

    # default dotfiles
    ./misc/xfce4/default.nix
    ./misc/fcitx5/default.nix
    ./misc/direnv.nix
  ];
}

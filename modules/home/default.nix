{ pkgs, ... }:

let
  myVars = import ../../myvars/gpd-pocket-3-idiig.nix;
in 

{
  imports = [

    # editors
    ./app/editor/emacs.nix
    ./app/editor/vim.nix
    ./app/editor/helix.nix

    # security-privacy
    ./app/security-privacy/ssh.nix
    ./app/security-privacy/gnupg.nix

    # version-management
    ./app/version-management/git.nix

    # browser
    ./app/browser/qutebrowser.nix
    # ./app/browser/firefox.nix

    # pdf reader
    ./app/pdf-reader/zathura.nix
    ./app/pdf-reader/evince.nix

    # image-processor
    ./app/image-processor/inkscape.nix
    ./app/image-processor/gimp.nix

    # multimedia
    ./app/multimedia/mocp.nix
    
    # shell
    ./app/shell/zsh.nix

    # word processor software
    ./app/word-processor/libreoffice.nix

    # cloud-service
    ./app/cloud-service/nextcloud.nix

    # reference-management
    ./app/reference-management/zotero.nix

    # terminal
    ./app/terminal/alacritty.nix
    ./app/terminal/tmux.nix

    # app launcher
    ./app/launcher/rofi.nix

    # appearance related
    ./app/appearance/picom.nix

    # notify
    ./app/notifier/dunst.nix

    # UI
    # ./ui/gtk.nix
    # ./ui/default-wallpaper.nix

    # default dotfiles
    # ./misc/xfce4/default.nix
    ./misc/fcitx5/default.nix
    ./misc/direnv.nix

    # languages
    ./lang/python.nix
    ./lang/nodejs.nix
  ];
}

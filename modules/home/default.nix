{ pkgs, ... }:

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
    # ./app/cloud-service/nutstore.nix
  
    # reference-management
    ./app/reference-management/zotero.nix

    # terminal
    ./app/terminal/alacritty.nix
  
    # UI
    ./ui/xfce4.nix
  ];
}

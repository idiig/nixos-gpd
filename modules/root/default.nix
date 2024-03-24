{ config, lib, pkgs, ... }:

{
  # General configurations
  imports = [

    ./nix.nix

    ./x11/xfce-xmonad.nix
    ./tty-login.nix

    ./bluetooth.nix
    ./keyboard.nix
    ./sound-audio.nix
    ./networking.nix
    
    ./datetime.nix
    ./cjk.nix
    ./fonts.nix
    ./key-rings.nix

    ./vim.nix
    ./git.nix
    ./command-line-tools.nix

  ];
}

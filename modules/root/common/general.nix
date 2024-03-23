{ config, lib, pkgs, ... }:

{
  # General configurations
  imports = [

    ./nix.nix
    ./basic.nix

    ./xserver/xfce-xmonad.nix
    ./tty-login.nix

    ./bluetooth.nix
    ./keyboard.nix
    ./sound-audio.nix
    ./network.nix
    
    ./datetime.nix
    ./cjk.nix
    ./fonts.nix
    ./key-rings.nix

  ];
}

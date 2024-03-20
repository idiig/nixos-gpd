{ config, lib, pkgs, ... }:

{
  # General configurations
  imports = [

    # General config 
    ./nix.nix

    ./xserver/xserver.nix
    ./tty-login.nix

    ./bluetooth.nix
    ./keyboard.nix
    ./sound-audio.nix
    ./network.nix
    
    ./datetime.nix
    ./cjk.nix
    ./fonts.nix

  ];
}

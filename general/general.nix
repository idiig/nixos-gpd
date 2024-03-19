{ config, lib, pkgs, ... }:

{
  # General configurations
  imports = [

    # General config 
    ./nix.nix

    ./xserver/xserver.nix
    ./ttyLogin.nix

    ./bluetooth.nix
    ./keyboard.nix
    ./soundAudio.nix
    ./network.nix
    
    ./datetime.nix
    ./font.nix
    ./inputMethods.nix

  ];
}

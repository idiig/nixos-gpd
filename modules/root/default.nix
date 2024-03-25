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
    ./security.nix
    
    ./datetime.nix
    ./cjk.nix
    ./fonts.nix

    ./vim.nix
    ./git.nix
    ./ssh.nix
    ./command-line-tools.nix

    ./system-tools.nix
    # https://github.com/ryan4yin/nix-config/blob/main/modules/nixos/base/zram.nix
    ./zram.nix
    # https://github.com/ryan4yin/nix-config/blob/main/modules/nixos/desktop/graphic.nix
    ./graphic.nix

  ];
}

{ config, lib, pkgs, ... }:

{
  # General configurations
  imports = [

    ./nix.nix

    ./tty-login.nix

    ./bluetooth.nix
    ./remap.nix
    ./sound-audio.nix
    ./networking.nix
    # # https://www.reddit.com/r/NixOS/comments/14qa7d8/control_both_suspend_and_brightness_on_lid_close/
    # ./power-management.nix
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

    ./x11/xfce-xmonad.nix
  ];
}

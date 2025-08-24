{ pkgs, ... }:

{
  # home.activation = '' rm -rf $Home/${myVars.user}/xfce4 '';
  home.file.".config/fcitx5".source = ./config;
}

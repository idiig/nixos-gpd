{ pkgs, ... }:

{
  # home.activation = '' rm -rf $Home/${myVars.user}/xfce4 '';
  home.file.".config/xfce4".source = ./xfce4;
}

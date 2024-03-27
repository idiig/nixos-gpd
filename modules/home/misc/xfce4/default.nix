# This config varies per machine
{ pkgs, ... }:

let
  myVars = import ../../../../myvars/gpd-pocket-3-idiig.nix;
in 

{
  # home.activation = '' rm -rf $Home/${myVars.user}/xfce4 '';
  home.file.".config/xfce4".source =
    ../../../../machines/${myVars.machine}/xfce4-config;
}

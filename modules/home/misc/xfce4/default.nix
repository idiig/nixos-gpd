# This config varies per machine
{ pkgs, ... }:

let
  myVars = import ../../../../myvars/gpd-pocket-3-idiig.nix;
in 

{
  # # home.activation = '' rm -rf $Home/${myVars.user}/xfce4 '';
  # home.file.".config/xfce4".source =
    # ../../../../machines/${myVars.machine}/xfce4-config;

  home.file.".config/xfce4/xfconf/xfce-perchannel-xml/displays.xml".source =
    ../../../../machines/${myVars.machine}/display/xfce4/displays.xml;

  home.file.".config/xfce4/xfconf/xfce-perchannel-xml/xsettings.xml".source =
    ../../../../machines/${myVars.machine}/display/xfce4/xsettings.xml;

  home.file.".config/xfce4/xfconf/xfce-perchannel-xml/xfce4-power-manager.xml".source =
    ./config/xfce4-power-manager.xml;

  home.file.".config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml".source =
    ./config/xfce4-panel.xml;

}

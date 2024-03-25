{ pkgs, ... }:

{
  home.packages = with pkgs; [
    feh
  ];
  

  # xsession = {
  #   enable = true;
  #   windowManager.command = ''

  #     # Set initial background image:
  #     feh --bg-fill --no-fehbg ./wallpaper/xfce-blue.jpg

  #   '';
  # };
}

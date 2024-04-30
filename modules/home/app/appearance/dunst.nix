{ config, lib, pkgs, ... }:

{

  services.dunst = {
    enable = true;
    configFile = "${config.home.homeDirectory}/.config/dunst/dunstrc";
    settings = {
      global = {
        width = 200;
        height = 50;
        offset = "10x28";
        origin = "top-right";
        transparency = 0;
        frame_color = "#dfdfdf";
        font = "CodingFontTobi 13";
      };
      urgency_normal = {
        background = "#dcdcdc";
        foreground = "#000000";
        timeout = 10;
      };
    };
    # iconTheme = {
    #   name = "Papirus-Dark";
    #   package = pkgs.papirus-icon-theme;
    # };
  };

}

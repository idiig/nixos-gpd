{ pkgs, ... }:

{
  # home.file."rofi" = {
  #   # TODO: use home-manager module
  #   source = ../../configs/rofi/.;
  #   recursive = true;
  # };
  programs = {
    rofi = {
      enable = true;
    };
  };

  services  = {
    dunst = {
      enable = true;
      # iconTheme = {
      #   name = "Papirus-Dark";
      #   package = pkgs.papirus-icon-theme;
      # };
    };
  };
}

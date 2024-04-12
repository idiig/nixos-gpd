{ pkgs, config, ... }:
{
  home.packages = [ pkgs.dropbox-cli ];

  services.dropbox = {
    enable = true;
    path = "${config.home.homeDirectory}/Nutstore";
  };
}

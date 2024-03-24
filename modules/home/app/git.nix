{ config, pkgs, ... }: 

{
  # Packages
  home.packages = [

    # Git
    pkgs.git

  ];

  # Git
  programs.git = {
    enable = true;
    # package = pkgs.gitFull;
    userName = "idiig";
    userEmail = "avionplat@hotmail.com";
  };

}

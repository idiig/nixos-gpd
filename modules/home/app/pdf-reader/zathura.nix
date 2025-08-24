{ config, lib, pkgs, ... }:

{
  home.packages = [
    # (pkgs.zathura.override { useMupdf = true; })
    pkgs.zathura
  ];

  # programs.zathura.enable = true;
}

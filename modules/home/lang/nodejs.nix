{ config, lib, pkgs, ... }:

{
  home.packages = [
    pkgs.nodejs_22
  ];
}

{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    deno
  ];
}

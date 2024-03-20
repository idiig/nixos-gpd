{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    autoconf 
    automake 
    pkg-config 
    glib 
    libtool 
    intltool
  ];
}

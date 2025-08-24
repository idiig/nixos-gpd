{ pkgs, ... }:

{
  home.packages = with pkgs; [
    nextcloud-client
    # nextcloud26
    # nextcloud27
    nextcloud28
  ];
}

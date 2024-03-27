{ pkgs, ... }:

{
  home.packages = [
    (pkgs.callPackage ./pkg.nix { }).nutstore
    (pkgs.callPackage ./pkg.nix { }).nutstore-unwrapped
    (pkgs.callPackage ./pkg.nix { }).default
  ];

}

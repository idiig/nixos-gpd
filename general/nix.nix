{ pkgs, ... }:

{
  # Allow unfree
  nixpkgs.config.allowUnfree = true;

  # Flakes etc.
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ]; 

  # Home-manager
  environment.systemPackages = [
    pkgs.home-manager
  ];
}

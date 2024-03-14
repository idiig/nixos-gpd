{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
  ];

  programs.git = {
    enable = true;
    package = pkgs.gitFull;
  };
}

{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git # used by nix flakes
    git-lfs # used by huggingface models
  ];

}

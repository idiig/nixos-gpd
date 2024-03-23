{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    emacs
  ];

  # programs.emacs = {
  #   enable = true;
  # };
}

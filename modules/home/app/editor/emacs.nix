{ pkgs, ... }: 

{
  # Packages
  home.packages = with pkgs; [
    emacs
  ];
}

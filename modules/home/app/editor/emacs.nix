{ pkgs, ... }: 

{
  # Packages
  home.packages = with pkgs; [
    ispell
    sqlite  # for org-roam
    cmigemo # for japanese
    emacs
  ];
}

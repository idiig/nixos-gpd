{ pkgs, ... }: 

{
  # Packages
  home.packages = with pkgs; [
    sqlite  # for org-roam
    emacs
    cmigemo # for japanese
  ];
}

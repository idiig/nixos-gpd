{ pkgs, ... }: 

{
  # Packages
  home.packages = with pkgs; [
    vscode
  ];
}

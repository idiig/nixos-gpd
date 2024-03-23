{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    alacritty
  ];

  environment.variables = {
    TERMINAL = "alacritty";
  };
}

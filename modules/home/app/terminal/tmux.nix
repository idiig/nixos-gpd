{ pkgs, fetchFromGitHub, ... }:

let

  tmux-powerline = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "tmux-powerline";
    version = "unstable-2024-04-19";
    src = pkgs.fetchFromGitHub {
      owner = "erikw";
      repo = "tmux-powerline";
      rev = "397b631924d2d16bb69f106485c63578dc0e202a";
      sha256 = "sha256-xgTR4aae5So8aHdGI1uFG7lazctIGbeZ4HkjCK9Ybuo=";
    };
  };

in

{

  home.packages = [
    pkgs.tmux
  ];
  
  programs.tmux = {
    enable = true;
    plugins = with pkgs; [
      tmux-powerline
      tmuxPlugins.better-mouse-mode
      tmuxPlugins.sensible
      tmuxPlugins.vim-tmux-navigator
    ];
    extraConfig = builtins.readFile ./tmux/tmux.conf; 
  };

  home.file.".config/tmux/fzf_panes.tmux".source = ./tmux/fzf_panes.tmux;

}

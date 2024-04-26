{ pkgs, ... }:

{
  home.packages = [
    pkgs.alacritty
  ];
  
  programs.alacritty = {
    enable = true;
    settings = {
      env = {
        "TERM" = "xterm-256color";
      };

      # background_opacity = 1.0;

      window = {
        padding.x = 10;
        padding.y = 8;
        decorations = "None";
      };

      font = {
        size = 8;
        # use_thin_strokes = true;

        # normal.family = "FuraCode Nerd Font";
        # bold.family = "FuraCode Nerd Font";
        # italic.family = "FuraCode Nerd Font";
      };

      cursor.style = "Beam";

      shell = {
        program = "zsh";
        args = [
          "-c"
          "tmux"
        ];
      };

      colors = {
        
        primary = {
          background = "0x202020";
          foreground = "0xd0d0d0";
        };

	      normal = {
          black = "0x000000";
          red = "0xc50f1f";
          green = "0x26a269";
          yellow = "0xa2734c";
          blue = "0x12488b";
          magenta = "0xa347ba";
          cyan = "0x2aa1b3";
          white = "0xd0d0d0";
        };

      	bright = {
          black = "0x555753";
          red = "0xef2929";
          green = "0x0d7a0d";
          yellow = "0xc17d11";
          blue = "0x1a5fb4";
          magenta = "0xbe3fbc";
          cyan = "0x16a2b4";
          white = "0xffffff";
        };
      };
      
    };
  };
}

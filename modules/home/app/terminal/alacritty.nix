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
        size = 23;
        # use_thin_strokes = true;

        # normal.family = "FuraCode Nerd Font";
        # bold.family = "FuraCode Nerd Font";
        # italic.family = "FuraCode Nerd Font";
      };

      cursor.style = "Beam";

      shell = {
        program = "zsh";
        # args = [
        #   "-C"
        #   "neofetch"
        # ];
      };

      colors = {
        # Default colors
        primary = {
          background = "0x1b182c";
          foreground = "0xcbe3e7";
        };

        # Normal colors
        normal = {
          black =   "0x100e23";
          red =     "0xff8080";
          green =   "0x95ffa4";
          yellow =  "0xffe9aa";
          blue =    "0x91ddff";
          magenta = "0xc991e1";
          cyan =    "0xaaffe4";
          white =   "0xcbe3e7";
        };

        # Bright colors
        bright = {
          black =   "0x565575";
          red =     "0xff5458";
          green =   "0x62d196";
          yellow =  "0xffb378";
          blue =    "0x65b2ff";
          magenta = "0x906cff";
          cyan =    "0x63f2f1";
          white = "0xa6b3cc";
        };
      };
      
      # regex = "((ipfs:|ipns:|magnet:|mailto:|gemini:|gopher:|https:|http:|news:|file:|git:|ssh:|ftp:)[^\u0000-\u001F\u007F-\u009F<>\"\\s{-}\\^⟨⟩`]+)|(([\\w\\.\\-_/]+/)*[\\w\\-_\\.]+\\.[\\w]+(:\\d+)?)";
      # hyperlinks = true;
      # command = open-with;  # 执行我上文提到的open-with
      # post_processing = true;
      
    };
  };
}

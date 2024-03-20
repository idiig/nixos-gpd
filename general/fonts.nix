{ pkgs, ... }:

{
  # Fonts
  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-extra
      noto-fonts-emoji
      #  liberation_ttf
      fira-code
      fira-code-symbols
      # mplus-outline-fonts
      dina-font
      proggyfonts
      dejavu_fonts
    ];
    
    fontconfig = {
      enable = true;
      defaultFonts = {
        sansSerif = [ "Noto Sans CJK JP" "DejaVu Sans" ];
        serif = [ "Noto Serif JP" "DejaVu Serif" ];
      };
      subpixel = { lcdfilter = "light"; };
    };
  };  
}

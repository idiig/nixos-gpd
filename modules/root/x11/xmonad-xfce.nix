{ pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
        dmenu # Expected by xmonad
        gxmessage # Used by xmonad to show help
        xorg.xkill # Kill X windows with the cursor
        pavucontrol # PulseAudio volume control UI
        brightnessctl # Brightness control CLI
        flameshot # A command-line screen capture utility
        pamixer # PulseAudio volume mixer
        pango # Rendering library used by xmobar
      ];
  };

  programs = {
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-media-tags-plugin
        thunar-volman
      ];
    };
  };

  # Display manager
  services.xserver = {
    enable = true;
    # dpi = 180;
    displayManager = {
      # defaultSession = "none+xmonad";
      defaultSession = "xfce+xmonad";
      startx.enable = true;
      autoLogin = {
        enable = true;
        user = "idiig";
      };
      lightdm = {
        enable = true;
        # greeters.gtk.enable = true;
        greeters.slick = {
          enable = true;
          theme.name = "Adwaita";
        };
      };
    };
    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      extraPackages = haskellPackages: [
        haskellPackages.xmonad-contrib
        haskellPackages.xmonad-extras
        haskellPackages.xmonad
        haskellPackages.greenclip # Clipboard manager for use with rofi
      ];
      config = builtins.readFile ./xmonad/xmonad.hs;
    };
    desktopManager = {
      xterm.enable = true;
      xfce = {
        enable = true;
        noDesktop = true;
        enableXfwm = false;
      };
    };
  };
}

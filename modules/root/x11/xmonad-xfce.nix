# XMonad with xfce4 feature

{ pkgs, ... }:

let

  xmonad-color-themes = builtins.path {
    path = ./xmonad/lib;
    name = "xmonad-color-themes";
  };

in

{
  environment = {
    systemPackages = with pkgs; [
      xmobar
      # xfce.xfce4-pulseaudio-plugin
      dmenu # Expected by xmonad
      gxmessage # Used by xmonad to show help
      xorg.xkill # Kill X windows with the cursor
      pavucontrol # PulseAudio volume control UI
      brightnessctl # Brightness control CLI
      flameshot # A command-line screen capture utility
      pamixer # PulseAudio volume mixer
      pango # Rendering library used by xmobar
      trayer # show system icon
    ];
    xfce.excludePackages = with pkgs.xfce; [
      # xfce4-screensaver-configure
      # xfce4-accessibility-settings
      # xfce4-screensaver-preferences
      # xfce4-appearance-settings
      # xfce4-screenshooter
      xfce4-appfinder
      # xfce4-session
      # xfce4-display-settings
      # xfce4-session-logout
      # xfce4-session-settings
      # xfce4-keyboard-settings
      # xfce4-settings-editor
      xfce4-taskmanager
      # xfce4-mouse-settings
      xfce4-terminal
      # xfce4-notifyd-config
      # xfconf-query
      # xfce4-pm-helper
      # xflock4  # lock screen
      # xfce4-power-manager
      # xfpm-power-backlight-helper
      # xfce4-power-manager-settings
      # xfce4-screensaver
      # xfsettingsd
      # xfce4-screensaver-command
    ];
    etc = {
      "xmobar".source = ./xmonad/xmobar; # xmobar theme
      "trayer/trayer-padding-icon.sh" = {
        source = ./xmonad/trayer-padding-icon.sh;
        mode = "0755";  # make excutable
      };
    };
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

  # Display/desktop/windows manager
  services.xserver = {
    enable = true;
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
        haskellPackages.xmobar
        haskellPackages.greenclip # Clipboard manager for use with rofi
      ];
      ghcArgs = [
        "-hidir /tmp" # place interface files in /tmp, otherwise ghc tries to write them to the nix store
        "-odir /tmp" # place object files in /tmp, otherwise ghc tries to write them to the nix store
        "-i ${xmonad-color-themes}" # tell ghc to search in the respective nix store path for the module
      ];
      config = builtins.readFile ./xmonad/xmonad-xfce.hs;
    };
    desktopManager = {
      xterm.enable = false;
      xfce = {
        enable = true;
        noDesktop = true;
        enableXfwm = false;
      };
    };
  };
}

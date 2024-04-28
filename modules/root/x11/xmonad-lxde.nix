# XMonad with lxde4 feature

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
    etc = {
      "xmobar".source = ./xmonad/xmobar; # xmobar theme
      "trayer/trayer-padding-icon.sh" = {
        source = ./xmonad/trayer-padding-icon.sh;
        mode = "0755";  # make excutable
      };
    };
  };

  programs.slock.enable = true;    # screenlocker

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
      config = builtins.readFile ./xmonad/xmonad-lx.hs;
    };
  };
}

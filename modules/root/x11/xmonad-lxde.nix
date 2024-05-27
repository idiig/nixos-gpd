# XMonad with lxde feature

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
      lxde.lxsession
      lxappearance
      pcmanfm

      xmobar
      dmenu # Expected by xmonad
      gxmessage # Used by xmonad to show help

      feh
      xorg.xkill # Kill X windows with the cursor
      # librsvg
      # gdk-pixbuf
      # gnome.adwaita-icon-theme
      # xscreensaver

      networkmanagerapplet # network control UI
      arandr # display manager
      # libnotify # for notify-send
      # pulseaudio # To use pactl
      # Helvum # pipewire UI
      qpwgraph  # pipewire UI
      pavucontrol # PulseAudio volume control UI
      brightnessctl # Brightness control CLI
      pamixer # PulseAudio volume mixer
      pango # Rendering library used by xmobar
      trayer # show system icon
      yad # xmonad hint key
    ];
    etc = {
      "xmobar".source = ./xmonad/xmobar; # xmobar theme
      "backgrounds".source = ./backgrounds; # xmobar theme
      "scripts/trayer-padding-icon.sh" = {
        source = ./scripts/trayer-padding-icon.sh;
        mode = "0755";  # make excutable
      };
      "scripts/notify-log" = {
        source = ./scripts/notify-log;
        mode = "0755";  # make excutable
      };
      "scripts/brightness-notify.sh" = {
        source = ./scripts/brightness-notify.sh;
        mode = "0755";  # make excutable
      };
      "scripts/volume-notify.sh" = {
        source = ./scripts/volume-notify.sh;
        mode = "0755";  # make excutable
      };
    };
  };

  # Display/desktop/windows manager
  services.displayManager = {
    defaultSession = "none+xmonad";
    autoLogin = {
      enable = true;
      user = "idiig";
    };
  };

  # screenlocker
  services.physlock = {

    enable = true;
    lockMessage = ";>";

    # Whether to disable SysRq when locked with physlock.
    disableSysRq = true;

    # muteKernelMessages = false;
    muteKernelMessages = true;

    # lock on target
    lockOn = {
      suspend = true;
      hibernate = true;
      extraTargets = [
        # "display-manager.service"
      ];
    };

    allowAnyUser = true;

  };

  # services.xscreensaver = {
  #   enable = true;
  #   package = pkgs.xscreensaver;
  # };

  # Or

  # programs.slock = {
  #   enable = true;
  #   package = pkgs.slock;
  # };

  services.xserver = {
    enable = true;
    displayManager = {
      startx.enable = true;
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
      config = builtins.readFile ./xmonad/xmonad-lxde.hs;
    };
  };
}

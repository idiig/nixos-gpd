{ pkgs, ... }:

{
  environment = {
    
    systemPackages = with pkgs; [
    
      elementary-xfce-icon-theme
      xfce.catfish
      xfce.gigolo
      xfce.orage
      # xfce.xfburn
      xfce.xfce4-appfinder
      xfce.xfce4-clipman-plugin
      xfce.xfce4-cpugraph-plugin
      xfce.xfce4-dict
      xfce.xfce4-fsguard-plugin
      xfce.xfce4-genmon-plugin
      xfce.xfce4-netload-plugin
      xfce.xfce4-panel
      xfce.xfce4-pulseaudio-plugin
      xfce.xfce4-systemload-plugin
      # xfce.xfce4-weather-plugin
      xfce.xfce4-whiskermenu-plugin
      xfce.xfce4-xkb-plugin
      xfce.xfdashboard
      xorg.xev
      # xsel
      # xtitle
      xwinmosaic

    ];
  };

  programs = {
    # dconf.enable = true;
    # gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };
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
    excludePackages = with pkgs; [
      xterm
    ];
    displayManager = {
      # defaultSession = "xfce";
      defaultSession = "xfce+xmonad";
      # startx.enable = true;
      # autoLogin = {
      #   enable = true;
      #   user = "idiig";
      # };
      # sddm.enable = false;
      # lightdm = {
      #   enable = true;
      #   greeters.slick = {
      #     enable = true;
      #     # theme.name = "Adwaita";
      #   };
      #   # autoLogin.timeout = 0;
      #   # greeter.enable = false;
      #   # greeters.mini.enable = {
      #   #   enable = true;
      #   #   user = "idiig";
      #   # };
      #   # greeters.gtk.enable = true;
      #   # greeters.mini.enable = true;
      # };
    };
    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      extraPackages = haskellPackages: [
        haskellPackages.xmonad-contrib
        haskellPackages.xmonad-extras
        haskellPackages.xmonad
      ];
      config = builtins.readFile ./xmonad.hs;
    };
    desktopManager.xfce = {
      enable = true;
      # noDesktop = true;
      enableXfwm = false;
    };
  };

}

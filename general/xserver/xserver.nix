{ pkgs, ... }:

{
  # Display manager
  # services.desktopManager.plasma6.enable =false;
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
      sddm.enable = false;
      lightdm = {
        enable = true;
        greeters.slick.enable = true;
        # autoLogin.timeout = 0;
        # greeter.enable = false;
        # greeters.mini.enable = {
        #   enable = true;
        #   user = "idiig";
        # };
        # greeters.gtk.enable = true;
        # greeters.mini.enable = true;
      };
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

  # Xfce Thunar goodies
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-media-tags-plugin
      thunar-volman
    ];
  };
}

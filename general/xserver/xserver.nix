_:

{
  # Display manager
  services.xserver = {
    enable = true;
    displayManager = {
      # defaultSession = "xfce";
      defaultSession = "xfce+xmonad";
      # startx.enable = true;
      # autoLogin = {
      #   enable = true;
      #   user = "idiig";
      # };
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
}

{ config, lib, pkgs, ... }:

{
  # boot.initrd.kernelModules=["i915"];
  # services.xserver.videoDrivers=["intel"];

  # GDK
  services.xserver.displayManager.lightdm.greeters.gtk.extraConfig = ''
    [LightDM]
    greeter-setup-script = GDK_SCALE=2
  '';

  services.xserver.displayManager.sessionCommands = ''
    ${pkgs.xorg.xrdb}/bin/xrdb -merge <<< 'Xft.dpi: 192'
  '';

  environment.variables = {
     GDK_SCALE = "1";
     GDK_DPI_SCALE = "1";
     _JAVA_OPTIONS = "-Dsun.java2d.uiScale=0.5";
     # QT_AUTO_SCREEN_SCALE_FACTOR = "1";
     # QT_ENABLE_HIGHDPI_SCALING = "1";
     # QT_SCREEN_SCALE_FACTORS = "0.5";
     QT_SCALE_FACTOR = "1";
     # QT_FONT_DPI = "96";
  };

}

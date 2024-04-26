{ config, lib, pkgs, ... }:

{
  # boot.initrd.kernelModules=["i915"];
  # services.xserver.videoDrivers=["intel"];

  # GDK
  services.xserver.displayManager.lightdm.greeters.gtk.extraConfig = ''
    [LightDM]
    greeter-setup-script = GDK_SCALE=2
  '';

  environment.variables = {
     GDK_SCALE = "1";
     GDK_DPI_SCALE = "0.5";
     _JAVA_OPTIONS = "-Dsun.java2d.uiScale=1";
     QT_SCALE_FACTOR = "0.5";
  };

}

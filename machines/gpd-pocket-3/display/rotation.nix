{ config, lib, pkgs, ... }:

{
  # GPU setting
  # services.xserver = {
    # videoDrivers = [ "amdgpu" ];  # for AMD
    # videoDrivers = [ "modesetting" ]
    # videoDrivers = [ "intel" ];
  # };

  # Display manager lightDM greeter rotation
  # DSI-I for modesetting; DSI for xf86-video-intel
  services.xserver.displayManager.setupCommands = ''
    ${pkgs.xorg.xrandr}/bin/xrandr --output DSI1 --rotate right # --scale 0.5x0.5
  '';
  services.xserver.displayManager.lightdm.greeters.gtk.extraConfig = ''
    # xft-dpi=192
    [LightDM]
    display-setup-script = GDK_SCALE=2
    greeter-setup-script = GDK_SCALE=2
  '';

  # Touch screen
  environment.etc."adjust-touch-screen.sh".text = ''
    xinput set-prop "GXTP7380:00 27C6:0113 Stylus Eraser (0)"  --type=float "Coordinate Transformation Matrix" 0 1 0 -1 0 1 0 0 1
    xinput set-prop "GXTP7380:00 27C6:0113 Stylus Pen (0)"  --type=float "Coordinate Transformation Matrix" 0 1 0 -1 0 1 0 0 1
    xinput set-prop "GXTP7380:00 27C6:0113"  --type=float "Coordinate Transformation Matrix" 0 1 0 -1 0 1 0 0 1
    xinput set-prop "Virtual core XTEST pointer"  --type=float "Coordinate Transformation Matrix" 0 1 0 -1 0 1 0 0 1
  '';
  services.xserver.displayManager.sessionCommands = ''
    bash /etc/adjust-touch-screen.sh
  '';

} 

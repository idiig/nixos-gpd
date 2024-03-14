{ pkgs, ... }:

{
  # Network
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };
  
  # Time and date
  time.timeZone = "Asia/Tokyo";
  
  # Keyboard
  console.useXkbConfig = true;
  services = {
    xserver = {
      layout = "us";
      xkbOptions = "ctrl:nocaps";
    };
  };
  
  # Sound
  sound.enable = true;

  # Audio
  hardware.pulseaudio.enable = true;

  # Bluetooth
  hardware.bluetooth.enable = true;
  # hardware.sensor.iio.enable = true;

  # Language
  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [
      "en_US.UTF-8/UTF-8" 
      "ja_JP.UTF-8/UTF-8"
      "zh_CN.UTF-8/UTF-8"
    ];
  };

  # Input methods
  i18n = {
    inputMethod = {
      enabled = "fcitx5"; 
#       fcitx5.addons = with pkgs; [
#         fcitx5-rime
#         fcitx5-skk
#       ];
    };
  }; 
  environment = {
    systemPackages = with pkgs; [
      fcitx5 
    ];
    variables = {
      GTX_IM_MODULE = "fcitx";
      QT_IM_MODULE = "fcitx";
      XMODIFIERS = "@im=fcitx";
    };
  };

  # Display and desktop manager
  services.xserver = {
    enable = true;
    # displayManager.sddm.enable = true;
    # desktopManager.plasma5.enable = true;
    displayManager.lightdm.enable = true;
    # displayManager.sessionCommands = ''
    #   ${pkgs.xorg.xrandr}/bin/xrandr --output DSI-1 --rotate right
    # '';
    desktopManager.xfce.enable = true;
  };
}

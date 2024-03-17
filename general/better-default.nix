{ pkgs, ... }:

{
  # Allow unfree
  nixpkgs.config.allowUnfree = true;
  
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
  
  # Fonts
  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-extra
      noto-fonts-emoji
      #  liberation_ttf
      fira-code
      fira-code-symbols
      # mplus-outline-fonts
      dina-font
      proggyfonts
      dejavu_fonts
    ];
    # 
    fontconfig = {
      enable = true;
      defaultFonts = {
        sansSerif = [ "Noto Sans CJK JP" "DejaVu Sans" ];
        serif = [ "Noto Serif JP" "DejaVu Serif" ];
      };
      subpixel = { lcdfilter = "light"; };
    };
  };  

  # Input methods
  i18n = {
    inputMethod = {
      enabled = "fcitx5"; 
      fcitx5.addons = with pkgs; [
        # Chinese
        fcitx5-rime
        fcitx5-chinese-addons
        # Japanese
        fcitx5-skk
      ];
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
    displayManager = {
      defaultSession = "xfce+xmonad";
      lightdm.enable = true;
    };
    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      extraPackages = haskellPackages: [
        haskellPackages.xmonad-contrib
        haskellPackages.xmonad-extras
        haskellPackages.xmonad
      ];
    };
    desktopManager.xfce = {
      enable = true;
      noDesktop = true;
      enableXfwm = false;
    };
  };
}

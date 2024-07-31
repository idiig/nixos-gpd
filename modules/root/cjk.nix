{ pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    skk-dicts
    skktools
    libskk
    librime
  ];

  i18n = {
    
    # Language
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [
      "en_US.UTF-8/UTF-8" 
      "ja_JP.UTF-8/UTF-8"
      "zh_CN.UTF-8/UTF-8"
    ];

    # Input methods
    inputMethod = {
      enable = "fcitx5";
      fcitx5.addons = with pkgs; [
        fcitx5-gtk
        # Chinese
        fcitx5-rime
        fcitx5-chinese-addons
        # Japanese
        fcitx5-skk
        # fcitx5-mozc
      ];
    };
  }; 

  environment.variables = {
    GTX_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    XMODIFIERS = "@im=fcitx";
  };

  # services.xserver.desktopManager.runXdgAutostartIfNone = true;

}

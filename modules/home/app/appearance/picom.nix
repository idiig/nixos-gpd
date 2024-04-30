{ ... }:

{
  services.picom = {
    enable = true;
    activeOpacity = 1.0;
    inactiveOpacity = 0.9;
    fade = false;
    fadeDelta = 5;
    fadeExclude = [
      "class_g = 'slop'"
    ];
    settings = {
      popup_menu = { opacity = 1.0; };
      dropdown_menu = { opacity = 1.0; };
      frame-opacity = 1;
      corner-radius = 0;
      rounded-corners-exclude = "class_g != 'eww-acpi_info'";
    };
    shadow = true;
    shadowOpacity = 0.5;
    # https://www.reddit.com/r/suckless/comments/g689o8/removing_comptonpicom_shadow_from_status_bar/
    shadowExclude = [
      "_NET_WM_STATE@:32a *= '_NET_WM_STATE_HIDDEN'"
      "class_g = 'eww-ewwbar'"
      "class_g = 'xmonad-decoration'"
      "class_g = 'trayer'"
      "class_g = 'rofi'"
    ];
  };
}

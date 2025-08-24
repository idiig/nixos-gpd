{ pkgs, ... }:

{
  home.sessionVariables = {
    GTK_KEY_THEME_NAME = "Emacs";
  };

  gtk = {
    enable = true;
      iconTheme = {
      name = "elementary-Xfce-dark";
      package = pkgs.elementary-xfce-icon-theme;
    };
    theme = {
      name = "Haiku";
      package = (pkgs.callPackage ./gtk-themes/haiku.nix { });
    };
    gtk2.extraConfig = ''
      gtk-key-theme-name = "Emacs"
    '';
    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
        gtk-key-theme-name = Emacs
      '';
    };
    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
  };
}

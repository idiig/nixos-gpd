{ pkgs, config, ... }:

let
  inherit (config.lib.formats.rasi) mkLiteral;
in

{
  # home.file."rofi" = {
  #   # TODO = use home-manager module
  #   source = ../../configs/rofi/.;
  #   recursive = true;
  # };
  programs.rofi = {
    enable = true;
    cycle = true;
    font = "Sans Regular 30";
    plugins = with pkgs; [
      rofi-screenshot
      rofi-pulse-select
      rofi-calc
      rofi-emoji
      rofi-file-browser
    ];
    theme = {

      "*" = {
        background-color = mkLiteral "#bcbcbc";
        foreground-color = mkLiteral "#000000";
        border-color = mkLiteral "#FFFFFF";
        active-color = mkLiteral "#FFFFFF";
        active-text-color = mkLiteral "#b3303a";
        width = 1280;
      };

      # "#configuration" = {
      #   modi = "drun,run,filebrowser,window";
      #   show-icons = false;
      #   display-drun = " Apps";
      #   display-run = " Run";
      #   display-filebrowser = " Files";
      #   display-window = " Windows";
      #   drun-display-format = "{name}";
      #   window-format = "{c} · {t}";
      # };

      "#inputbar" = {
        children = map mkLiteral [ "prompt" "entry" ];
      };

      "#textbox-prompt-colon" = {
        expand = false;
        str = " = ";
        margin = mkLiteral "0px 0.3em 0em 0em";
        text-color = mkLiteral "@foreground-color";
      };

      "#entry" = {
        enabled = true;
        padding = mkLiteral "0px 0.3em 0em 0.5em";
        # background-color = inherit;
        # text-color = inherit;
        # cursor = text;
        placeholder = "Search ...";
        # placeholder-color = inherit;
      };

      "#mainbox" = {
        enabled = true;
        spacing = mkLiteral "10px";
        margin = mkLiteral "0px";
        padding = mkLiteral "20px";
        border = mkLiteral "2px solid";
        border-radius = mkLiteral "0px 0px 0px 0px";
        border-color = mkLiteral "@border-color";
        background-color = mkLiteral "transparent";
        # children = map mkLiteral [ "inputbar" "mode-switcher" "message" "listview" ];
      };

      "#num-filtered-rows" = {
        enabled = true;
        expand = false;
        # background-color = inherit;
        # text-color = inherit;
      };

      "#textbox-num-sep" = {
        enabled = true;
        expand = false;
        str = "/";
        # background-color = inherit;
        # text-color = inherit;
      };

      "#num-rows" = {
        enabled = true;
        expand = false;
        # background-color = inherit;
        # text-color = inherit;
      };

      "#case-indicator" = {
        enabled = true;
        # background-color = inherit;
        # text-color = inherit;
      };

      "#element selected.normal" = {
        background-color = mkLiteral "@active-color";
        text-color = mkLiteral "@active-text-color";
      };

      "#element-icon" = {
        background-color = mkLiteral "transparent";
        # text-color = inherit;
        size = mkLiteral "35px";
        # cursor = inherit;
      };

      "#element-text" = {
        background-color = mkLiteral "transparent";
        # text-color = inherit;
        highlight = mkLiteral "@active-text-color";
        # cursor = inherit;
        vertical-align = mkLiteral "0.5";
        horizontal-align = mkLiteral "0";
      };

    };
  };
}

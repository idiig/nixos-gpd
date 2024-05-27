{ config, lib, pkgs, ... }:

{
  programs.helix = {
    enable = true;
    settings = {
      theme = "gruvbox";
      editor = {
        mouse = true;
        cursorline = true;
        true-color = true;
        scrolloff = 8;
        scroll-lines = 1;
        color-modes = true;
        auto-save = false;
        bufferline = "multiple";
        rulers = [120];
        auto-pairs = true;
        shell = ["zsh" "-c"];
        completion-trigger-len = 1;
        idle-timeout = 80;
        search.smart-case = true;

        gutters = {
          layout = ["diff" "diagnostics" "line-numbers" "spacer"];
          line-numbers.min-width = 1;
        };

        lsp = {
          display-messages = true;
          display-inlay-hints = true;
        };

        cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "block";
        };


        whitespace = {
          render = {
            space = "none";
            tab = "all";
            newline = "none";
          };
          characters = {
            # space = "·";
            nbsp = "⍽";
            tab = "▏";
            newline = "⏎";
            # tabpad = "·"
          };
        };

        indent-guides = {
          render = true;
          character = "╎"; # Some characters that work well: "▏", "╎", "┆", "┊", "⸽"
          # skip-levels = 1
        };

        statusline = {
          left = [
            "mode"
            "spinner"
            "file-name"
            "file-type"
            "total-line-numbers"
            "file-encoding"
          ];
          center = [];
          right = [
            "selections"
            "primary-selection-length"
            "position"
            "position-percentage"
            "spacer"
            "diagnostics"
            "workspace-diagnostics"
            "version-control"
          ];
          separator = "│";
        };
      };
    };

    languages.language = [{
      name = "nix";
      auto-format = true;
      formatter.command = "${pkgs.nixfmt-classic}/bin/nixfmt-classic";
    }];

    themes = {
      # autumn_night_transparent = {
      #   "inherits" = "autumn_night";
      #   "ui.background" = { };
    };
  };
}

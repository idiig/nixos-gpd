{ pkgs, fetchFromGitHub, ... }:

let

  tmux-powerline = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "tmux-powerline";
    version = "unstable-2024-04-19";
    rtpFilePath = "main.tmux";
    src = pkgs.fetchFromGitHub {
      owner = "erikw";
      repo = "tmux-powerline";
      rev = "397b631924d2d16bb69f106485c63578dc0e202a";
      sha256 = "sha256-xgTR4aae5So8aHdGI1uFG7lazctIGbeZ4HkjCK9Ybuo=";
    };
  };

  tmux-nvim = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "tmux.nvim";
    version = "unstable-2023-01-06";
    src = pkgs.fetchFromGitHub {
      owner = "aserowy";
      repo = "tmux.nvim/";
      rev = "57220071739c723c3a318e9d529d3e5045f503b8";
      sha256 = "sha256-zpg7XJky7PRa5sC7sPRsU2ZOjj0wcepITLAelPjEkSI=";
    };
  };
  
  tmux-super-fingers = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "tmux-super-fingers";
    version = "unstable-2023-01-06";
    src = pkgs.fetchFromGitHub {
      owner = "artemave";
      repo = "tmux_super_fingers";
      rev = "2c12044984124e74e21a5a87d00f844083e4bdf7";
      sha256 = "sha256-cPZCV8xk9QpU49/7H8iGhQYK6JwWjviL29eWabuqruc=";
    };
  };

  t-smart-manager = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "t-smart-tmux-session-manager";
    version = "unstable-2023-01-06";
    rtpFilePath = "t-smart-tmux-session-manager.tmux";
    src = pkgs.fetchFromGitHub {
      owner = "joshmedeski";
      repo = "t-smart-tmux-session-manager";
      rev = "a1e91b427047d0224d2c9c8148fb84b47f651866";
      sha256 = "sha256-HN0hJeB31MvkD12dbnF2SjefkAVgtUmhah598zAlhQs=";
    };
  };
in

{

  home.packages = with pkgs; [
    tmux
    # tmux-powerline
  ];
  
  programs.tmux = {
    enable = true;
    extraConfig = builtins.readFile ./tmux/tmux.conf; 
    plugins = with pkgs; [
      tmuxPlugins.tmux-thumbs
      tmuxPlugins.better-mouse-mode
      tmuxPlugins.yank
      tmuxPlugins.vim-tmux-navigator
      tmuxPlugins.sensible
      # must be before continuum edits right status bar
      {
        plugin = tmuxPlugins.catppuccin;
        extraConfig = '' 
          set -g @catppuccin_flavour 'frappe'
          set -g @catppuccin_window_tabs_enabled on
          set -g @catppuccin_date_time "%H:%M"
        '';
      }
      {
        plugin = tmuxPlugins.resurrect;
        extraConfig = ''
          set -g @resurrect-strategy-vim 'session'
          set -g @resurrect-strategy-nvim 'session'
          set -g @resurrect-capture-pane-contents 'on'
        '';
      }
      {
        plugin = tmuxPlugins.continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-boot 'on'
          set -g @continuum-save-interval '10'
        '';
      }

      tmux-nvim
      {
        plugin = tmux-powerline;
        extraConfig = ''
          # set-option -g status-left "#(${tmux-powerline}/share/tmux-plugins/tmux-powerline/powerline.sh left)"
          # set-option -g status-right "#(${tmux-powerline}/share/tmux-plugins/tmux-powerline/powerline.sh right)"
        '';
      } 
      {
        plugin = t-smart-manager;
        extraConfig = ''
          set -g @t-fzf-prompt '  '
          set -g @t-bind "T"
        '';
      }
      {
        plugin = tmux-super-fingers;
        extraConfig = "set -g @super-fingers-key f";
      }
    ];
  };

  home.file.".config/tmux/fzf_panes.tmux".source = ./tmux/fzf_panes.tmux;
  home.file.".config/tmux-powerline/config.sh".source = ./tmux/tmux-powerline/config.sh;
}

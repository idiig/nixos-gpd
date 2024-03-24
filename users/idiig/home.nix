{ config, pkgs, ... }: 
{
  # isSystemUser = true;

  home.stateVersion = "23.11";

  # Packages
  home.packages = [
    pkgs.hello

    # Git
    pkgs.git
    
    # Firefox
    pkgs.firefox

    # xfce4-themes
    (pkgs.callPackage ./gtk-themes/haiku.nix { })
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/idiig/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Git
  programs.git = {
    enable = true;
    userName = "idiig";
    userEmail = "avionplat@hotmail.com";
  };

  # SSH
  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host github.com
        IdentityFile ~/.ssh/id_ed25519
    '';
  };

  # # Vim
  # programs.vim = {
  #   enable = true;
  #   plugins = with pkgs.vimPlugins; [
  #     vim-nix 
  #     vim-lastplace 
  #     vim-surround
  #     vim-repeat
  #     vim-commentary
  #     vim-easy-align
  #     auto-pairs
  #     vim-airline 
  #   ];
  #   extraConfig = ''
  #     syntax on 
  #     filetype plugin indent on
  #     set mouse=a
  #     set number rnu
  #     set tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
  #     set backspace=indent,eol,start
  #     set incsearch
  #     set tw=76 ruler
  #     inoremap <S-Tab> <C-V><Tab>
  #     set laststatus=2
  #     set clipboard=unnamedplus
  #   '';
  # }; 
}

{ config, pkgs, ... }: # let
  # Use `import` and pass arguments explicitly when not importing a
  # package definition.
  #
  # Technically `callPackage` works, since it just assigns arguments
  # to an imported function, and `pkgs` is one of the potential
  # assignments, but we're not calling a package, so let's not
  # pretend.
  # mypkgs = import ./gtk-themes/haiku.nix { inherit pkgs; }; 
  # in 
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "idiig";
  home.homeDirectory = "/home/idiig";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    
    # Git
    pkgs.git
    
    # Firefox
    pkgs.firefox

    # xfce4-themes
    # mypkgs.Haiku
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


  # # Xfce Thunar goodies
  # programs.thunar = {
  #   enable = true;
  #   plugins = with pkgs.xfce; [
  #     thunar-archive-plugin
  #     thunar-media-tags-plugin
  #     thunar-volman
  #   ];
  # };

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

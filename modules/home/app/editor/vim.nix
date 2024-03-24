{ config, pkgs, ... }: 

{

  # Packages
  home.packages = with pkgs; [
    # vim  # comment out for conflict with root/vim
    neovim
  ];

  # Vim
  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      vim-nix 
      vim-lastplace 
      vim-surround
      vim-repeat
      vim-commentary
      vim-easy-align
      auto-pairs
      vim-airline 
    ];
    extraConfig = ''
      syntax on 
      filetype plugin indent on
      set mouse=a
      set number rnu
      set tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
      set backspace=indent,eol,start
      set incsearch
      set tw=76 ruler
      inoremap <S-Tab> <C-V><Tab>
      set laststatus=2
      set clipboard=unnamedplus
    '';
  }; 
}

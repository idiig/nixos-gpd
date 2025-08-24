{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    ((vim_configurable.override {  }).customize {
      name = "vim";
      # Plugins
      vimrcConfig.packages.myplugins = with pkgs.vimPlugins; {
        start = [ 
          vim-nix 
          vim-lastplace 
          vim-surround
          vim-repeat
          vim-commentary
          vim-easy-align
          auto-pairs
          vim-airline
        ];
        opt = [];
      };
      # VimRC
      vimrcConfig.customRC = ''
        syntax on 
        filetype plugin indent on
        set number rnu
        set tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
        set backspace=indent,eol,start
        set incsearch
        set tw=76 ruler
        inoremap <S-Tab> <C-V><Tab>
        set laststatus=2
        set clipboard=unnamedplus
      '';
    })
  ];
}

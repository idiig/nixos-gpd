{ config, lib, pkgs, ... }:

{
   imports =
    [ 
      ./tools/vim.nix
      ./tools/emacs.nix
      ./tools/git.nix
      ./tools/zsh.nix
      ./tools/alacritty.nix

    ];
}

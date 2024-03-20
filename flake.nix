{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    # flake-util.url = "github:numtide/flake-utils";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    # home-manager.url = "github:nix-community/home-manager";
  };

  outputs = { 
    self, 
    nixpkgs, 
    nixos-hardware, 
    # flake-util, 
    # home-manager, 
    ... 
  }@attrs: {

    packages.x86_64-linux.hello = nixpkgs.legacyPackages.x86_64-linux.hello;

    packages.x86_64-linux.default = self.packages.x86_64-linux.hello;
    
    nixosConfigurations.gpd-pocket-3 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = attrs;
      modules = [

        # Automatically generated configuration.nix (Delete boot part)
        ./configuration.nix

        # Hardware
        nixos-hardware.nixosModules.gpd-pocket-3

        # Boot config
        ./per-machine/gpd-pocket-3/boot.nix  #

        # Display rotation
        ./per-machine/gpd-pocket-3/rotation.nix

        # General setting
        ./general/general.nix

        # Basic tools
        ./tools/vim.nix
        ./tools/emacs.nix
        ./tools/git.nix
        ./tools/zsh.nix
        # ./tools/alacritty.nix

      ];
    };
  };
}

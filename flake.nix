{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # flake-util.url = "github:numtide/flake-utils";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = { self, nixpkgs, nixos-hardware, ... }@attrs: {

    # packages.x86_64-linux.hello = nixpkgs.legacyPackages.x86_64-linux.hello;

    # packages.x86_64-linux.default = self.packages.x86_64-linux.hello;
    
    nixosConfigurations.gpd-pocket-3 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = attrs;
      modules = [

        # Default configuration.nix
        ./configuration.nix

        # Hardware
        nixos-hardware.nixosModules.gpd-pocket-3
        ./per-machine/gpd-pocket-3/hardware-configuration.nix
        
        # Additional config per machine
        ./per-machine/gpd-pocket-3/boot.nix  #
        ./per-machine/gpd-pocket-3/additional-config.nix

        # General setting
        ./general/nix.nix
        ./general/default.nix

        # Basic tools
        ./tools/home-manager.nix
        ./tools/alacritty.nix
        ./tools/vim.nix
        ./tools/emacs.nix
        ./tools/git.nix
        ./tools/zsh.nix

      ];
    };

  };
}

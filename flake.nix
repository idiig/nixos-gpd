{
  description = "";

  inputs = {

    # pkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Extra
    home-manager.url = "github:nix-community/home-manager";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    flake-util.url = "github:numtide/flake-utils";
    xremap-flake.url = "github:xremap/nix-flake";

  };

  outputs = { 
    self, 
    nixpkgs,
    nixpkgs-unstable,

    flake-util,
    home-manager,    # for users/<usr>/default.nix
    nixos-hardware,  # for machines/<machine>/hardware-configuration.nix
    xremap-flake,    # for remap; modules/root/remap/remap.nix
    ... 
  }@inputs:

  let
    myVars = import ./myvars/gpd-pocket-3-idiig.nix;
    system = "x86_64-linux";
    specialArgs = inputs // { inherit system; };
  in 

  {

    # packages.x86_64-linux.hello = nixpkgs.legacyPackages.x86_64-linux.hello;

    # packages.x86_64-linux.default = self.packages.x86_64-linux.hello;

    nixosConfigurations.gpd-pocket-3 = nixpkgs-unstable.lib.nixosSystem {

      system = system;
      specialArgs = specialArgs;

      modules = [
        
        # Automatically generated configuration.nix (Delete boot part)
        ./configuration.nix

        # Machine related extra config
        ./machines/${myVars.machine}/hardware-configuration.nix

        # General setting
        ./modules/root/default.nix

        # User setting
        ./users/${myVars.user}/default.nix

      ];
    };
  };
}

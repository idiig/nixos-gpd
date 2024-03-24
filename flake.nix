{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    # flake-util.url = "github:numtide/flake-utils";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    # home-manager.url = "github:nix-community/home-manager";
  };

  outputs = { 
    self, 
    nixpkgs, 
    nixos-hardware, 
    # flake-util, 
    home-manager, 
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
        ./machines/gpd-pocket-3/boot.nix

        # Display and touch rotation
        ./machines/gpd-pocket-3/rotation.nix

        # General setting
        ./modules/root/default.nix

        # User setting
        ./users/idiig/base.nix
        home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            # home-manager.users.idiig.isSystemUser = true;

            home-manager.users.idiig = import ./users/idiig/home.nix;
            # home-manager.users.idiig.home.homeDirectory

          }
      ];
    };
  };
}

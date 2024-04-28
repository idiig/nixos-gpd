{ home-manager, ... }:

{
  imports = [

    # Usr
    ./config.nix

    # Extra app
    home-manager.nixosModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.idiig = import ./home.nix;
    }

  ];

}

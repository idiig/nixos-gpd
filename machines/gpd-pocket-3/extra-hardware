{ nixos-hardware, ... }:

{
  imports = [

    # Hardware auto
    nixos-hardware.nixosModules.gpd-pocket-3

    # Boot config
    ./boot.nix

    # Display and touch rotation
    ./display/rotation.nix

    # Scale
    ./display/scale.nix

    # Suspend and hibernate
    ./suspend-hibernate.nix

  ];
}

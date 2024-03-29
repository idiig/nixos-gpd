_:

{
  imports = [

    # Boot config
    ./boot.nix

    # Display and touch rotation
    ./rotation.nix

    # Suspend and hibernate
    ./suspend-hibernate.nix

  ];
}

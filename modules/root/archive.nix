{
  pkgs,
  ...
} 

{

  environment.systemPackages = with pkgs; [

    # archives
    zip
    xz
    zstd
    unzip
    p7zip

  ];

}

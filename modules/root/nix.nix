{ pkgs, ... }:

{
  # Allow unfree
  nixpkgs.config.allowUnfree = true;

  # Flakes etc.
  nix.settings = {
    # enable flakes globally
    experimental-features = ["nix-command" "flakes"];

    # given the users in this list the right to specify additional substituters via:
    #    1. `nixConfig.substituers` in `flake.nix`
    #    2. command line args `--options substituers http://xxx`
    trusted-users = ["idiig"];

    # substituers that will be considered before the official ones(https://cache.nixos.org)
    substituters = [
      # cache mirror located in China
      # status: https://mirror.sjtu.edu.cn/
      # "https://mirror.sjtu.edu.cn/nix-channels/store"
      # status: https://mirrors.ustc.edu.cn/status/
      "https://mirrors.ustc.edu.cn/nix-channels/store"
      "https://nix-community.cachix.org"
    ];

    builders-use-substitutes = true;
  };

  # Home-manager
  environment.systemPackages = [
    pkgs.home-manager
  ];

}

{ config, pkgs, ... }: 

{

  home.stateVersion = "23.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  imports = [

    ../../modules/home/default.nix

    # extra app
    ../../modules/home/app/multimedia/spotify.nix
    ../../modules/home/app/multimedia/obs-studio.nix
    ../../modules/home/app/browser/firefox.nix
    ../../modules/home/app/meeting/zoom.nix
    ../../modules/home/app/editor/vscode.nix

  ];

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/idiig/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "emacs";
  };

}

{ config, pkgs, ... }: 

{

  home.stateVersion = "23.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # extra app
  imports = [
    ../../modules/home/default.nix
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

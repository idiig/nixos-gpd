{ config, pkgs, lib, ... }:

{

  # environment.systemPackages = with pkgs; [ 
  #   gpg
  #   gnupg
  # ];

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  
  # programs.gpg.enable = true;

  # services.gpg-agent.enable = true;
  
}

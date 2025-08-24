{ pkgs, ... }: 

{

  # Packages
  home.packages = with pkgs; [
    gnupg
  ];

  # # GnuPG
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  
  # programs.gpg.enable = true;
  # services.gpg-agent.enable = true;

}

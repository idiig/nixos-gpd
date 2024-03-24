{ config, pkgs, ... }: 

{

  # Packages
  home.packages = with pkgs; [
    openssh
    gnupg
    # gpg
  ];

  # SSH
  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host github.com
        IdentityFile ~/.ssh/id_ed25519
    '';
  };

  # # GnuPG
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  
  # programs.gpg.enable = true;
  # services.gpg-agent.enable = true;

}

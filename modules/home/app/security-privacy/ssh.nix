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
      
    Host macair23
      HostName 124.38.172.203
      User idiig
      UserKnownHostsFile /dev/null
      PreferredAuthentications publickey
      StrictHostKeyChecking no
      PasswordAuthentication no
      IdentityFile ~/.ssh/idiig_nixos
      IdentitiesOnly yes
      LogLevel FATAL
    '';
  };

}

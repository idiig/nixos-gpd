{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [

    # networking tools
    mtr # A network diagnostic tool
    iperf3
    dnsutils # `dig` + `nslookup`
    ldns # replacement of `dig`, it provide the command `drill`
    socat # replacement of openbsd-netcat
    nmap # A utility for network discovery and security auditing
    ipcalc # it is a calculator for the IPv4/v6 addresses

  ];

  # Network
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };
}

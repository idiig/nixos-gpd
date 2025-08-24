{ pkgs, xremap-flake, ... }:

{
  imports = [ xremap-flake.nixosModules.default ];

  # Keyboard
  console.useXkbConfig = true;

  # fix xremap cant assign remap per app
  # https://github.com/xremap/nix-flake/issues/55
  systemd.user.services.x11auth-setup = {
    script = ''
      ${pkgs.xorg.xhost}/bin/xhost +SI:localuser:root
    '';
    wantedBy = [ "graphical-session.target" "xremap.service" ];
    partOf = [ "graphical-session.target" ];
  };

  services.xserver.displayManager.sessionCommands = ''
    # xremap
    ${pkgs.xorg.xhost}/bin/xhost +SI:localuser:root
    # sudo systemctl restart xremap
  '';

  # Keymap
  services.xremap = {
    serviceMode = "system";
    yamlConfig = builtins.readFile ./remap.yml;
    # debug = true;
    withX11 = true;
  };

}

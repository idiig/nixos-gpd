_:

{

users.users.idiig = {
  # isSystemUser = true;
  isNormalUser = true;
  home = "/home/idiig";
  group = "system";
  extraGroups = [ "wheel" ];  # to use sudo
};

users.groups.system = {};

}

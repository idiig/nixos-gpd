_:

{
  security.pam.services.gdm.enableGnomeKeyring = true;

  services = {
    gnome.gnome-keyring.enable = true;
    # pipewire = {
    #   enable = true;
    #   alsa = {
    #     enable = true;
    #     support32Bit = true;
    #   };
    #   pulse.enable = true;
    # };
  };
}

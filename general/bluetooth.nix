{ pkgs, ... }:

{
  environment.systemPackages = [pkgs.blueman]

  # Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot

  # Blueman
  services.blueman.enable = true;
}

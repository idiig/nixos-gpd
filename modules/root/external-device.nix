{ config, lib, pkgs, ... }:

{
  boot.initrd.availableKernelModules = [
    "hid_cherry"
    "hid_generic"
    "usbhid"
    "hid"
  ];
}

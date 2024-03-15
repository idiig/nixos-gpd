_:{
  # Use the systemd-boot EFI boot loader.
  # boot.loader.systemd-boot.enable = true;
  # boot.loader.efi.canTouchEfiVariables = true;
  boot.loader = {
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      extraEntries = ''
        memuentry "Windows" {
	  search --file --no-floppy --set=root /EFI/Microsoft/Boot/bootmgfw.efi
	  chainloader (''${root}/EFI/Microsoft/Boot/bootmgfw.efi
	}
      '';
      extraConfig = ''
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash apparmor=1 security=apparmor udev.log_priority=3 fbcon=rotate:1 video=DSI-1:panel_orientation=right_side_up" 
GRUB_CMDLINE_LINUX="quiet splash noautomount fbcon=rotate:1 video=DSI-1:panel_orientation=right_side_up"
      '';
    };
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
  };
  # boot rotation
  boot.kernelParams = [
    # "apci=off"
    "quiet"
    "splash"
    "apparmor=1"
    "security=apparmor"
    "udev.log_priority=3"
    "fbcon=rotate:1"
    "video=DSI-1:panel_orientation=right_side_up"
  ];
}

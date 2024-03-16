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
    };
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
  }; 
  # boot.kernelParams = [
  #   # The GPD Pocket3 uses a tablet OLED display, that is mounted rotated 90° counter-clockwise
  #   "fbcon=rotate:1" "video=DSI-1:panel_orientation=right_side_up"
  #   "quiet" "apparmor=1" "security=apparmorudev.log_priority=3"
  # ];
}

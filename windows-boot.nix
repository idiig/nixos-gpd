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
}

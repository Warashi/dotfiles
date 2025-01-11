{
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/936af564-37fc-4d9d-bd56-e475ad57c047";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/2F59-86C4";
    fsType = "vfat";
    options = [
      "fmask=0022"
      "dmask=0022"
    ];
  };
}

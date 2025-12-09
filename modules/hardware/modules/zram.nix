{ config, lib, ... }:

{
  options = {
    ixnay.hardware.zram.enable = lib.mkEnableOption "zram";
  };

  config = lib.mkIf config.ixnay.hardware.zram.enable {
    boot = {
      kernel = {
        sysctl = {
          # SOURCE https://wiki.archlinux.org/title/Zram#Optimizing_swap_on_zram
          "vm.swappiness" = 180;
          "vm.watermark_boost_factor" = 0;
          "vm.watermark_scale_factor" = 125;
          "vm.page-cluster" = 0;
        };
      };
    };

    zramSwap = {
      enable = true;
      algorithm = "zstd";
      memoryPercent = 150;
      priority = 100;
    };
  };
}

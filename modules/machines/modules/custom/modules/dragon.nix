{ config, lib, ... }:

{
  options = {
    ixnay.machines.custom.dragon.enable = lib.mkEnableOption "Custom PC: dragon";
  };

  config = lib.mkIf config.ixnay.machines.custom.dragon.enable {
    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

    boot = {
      initrd = {
        availableKernelModules = [
          "nvme"
          "xhci_pci"
          "ahci"
          "usbhid"
          "usb_storage"
          "sd_mod"
        ];
        kernelModules = [ ];
      };
      kernelModules = [ "kvm-amd" ];
      extraModulePackages = [ ];
    };

    ixnay = {
      services = {
        network.enable = true;
      };

      hardware = {
        audio.enable = true;
        bluetooth.enable = true;
        cpu-amd.enable = true;
        drive.enable = true;
        fwupd.enable = true;
        gpu-amd.enable = true;
        gpu-universal.enable = true;
        wireless.enable = true;
        zram.enable = true;
      };
    };
  };
}

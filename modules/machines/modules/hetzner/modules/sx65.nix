{ config, lib, ... }:

{
  options = {
    ixnay.machines.hetzner.sx65.enable = lib.mkEnableOption "Hetzner SX65 Server";
  };

  config = lib.mkIf config.ixnay.machines.hetzner.sx65.enable {
    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

    boot = {
      initrd = {
        availableKernelModules = [
          "xhci_pci"
          "ahci"
          "nvme"
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
        cpu-amd.enable = true;
        drive.enable = true;
        fwupd.enable = true;
        zram.enable = true;
      };
    };
  };
}

{
  config,
  lib,
  pkgs,
  ...
}:

let
  zfsCompatibleKernelPackages = lib.filterAttrs (
    name: kernelPackages:
    (builtins.match "linux_[0-9]+_[0-9]+" name) != null
    && (builtins.tryEval kernelPackages).success
    && (!kernelPackages.${config.boot.zfs.package.kernelModuleAttribute}.meta.broken)
  ) pkgs.linuxKernel.packages;
  latestKernelPackage = lib.last (
    lib.sort (a: b: (lib.versionOlder a.kernel.version b.kernel.version)) (
      builtins.attrValues zfsCompatibleKernelPackages
    )
  );
in
{
  options = {
    ixnay.services.zfs.enable = lib.mkEnableOption "zfs";
  };

  config = lib.mkIf config.ixnay.services.zfs.enable {
    boot = {
      supportedFilesystems = [ "zfs" ];
      kernelPackages = latestKernelPackage;
      zfs = {
        removeLinuxDRM = true;
        forceImportRoot = false;
      };
    };

    services = {
      zfs = {
        autoScrub = {
          enable = true;
          interval = "*-*-01,15 00:00:00 UTC";
          pools = [ ];
        };

        trim = {
          enable = true;
          interval = "*-*-07,21 00:00:00 UTC";
        };

        autoSnapshot = {
          enable = true;
          flags = "-k -p --utc";
        };
      };
    };
  };
}

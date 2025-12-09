{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    ixnay.hardware.gpu-amd.enable = lib.mkEnableOption "gpu-amd";
  };

  config = lib.mkIf config.ixnay.hardware.gpu-amd.enable {
    environment.systemPackages = with pkgs; [
      amdgpu_top
      clinfo
    ];

    hardware = {
      amdgpu = {
        initrd.enable = true;
        opencl.enable = true;
        overdrive.enable = true;
      };
    };

    systemd.tmpfiles.rules =
      let
        rocmEnv = pkgs.symlinkJoin {
          name = "rocm-combined";
          paths = with pkgs.rocmPackages; [
            rocblas
            hipblas
            clr
          ];
        };
      in
      [ "L+    /opt/rocm   -    -    -     -    ${rocmEnv}" ];
  };
}

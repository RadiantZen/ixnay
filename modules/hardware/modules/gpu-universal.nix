{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    ixnay.hardware.gpu-universal.enable = lib.mkEnableOption "gpu-universal";
  };

  config = lib.mkIf config.ixnay.hardware.gpu-universal.enable {
    environment.systemPackages = with pkgs; [
      libva-utils
      vulkan-tools
    ];

    services = {
      lact = {
        enable = true;
      };
    };

    hardware = {
      graphics = {
        enable = true;
        enable32Bit = true;
      };
    };
  };
}

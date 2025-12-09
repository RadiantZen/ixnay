{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    ixnay.programs.create.blender.enable = lib.mkEnableOption "blender";
  };

  config = lib.mkIf config.ixnay.programs.create.blender.enable {
    environment = {
      systemPackages = with pkgs; [ blender ];
    };
  };
}

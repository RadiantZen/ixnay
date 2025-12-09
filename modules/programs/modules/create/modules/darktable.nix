{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    ixnay.programs.create.darktable.enable = lib.mkEnableOption "darktable";
  };

  config = lib.mkIf config.ixnay.programs.create.darktable.enable {
    environment = {
      systemPackages = with pkgs; [ darktable ];
    };
  };
}

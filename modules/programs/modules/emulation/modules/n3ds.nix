{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    ixnay.programs.emulation.n3ds.enable = lib.mkEnableOption "3ds emulation";
  };

  config = lib.mkIf config.ixnay.programs.emulation.n3ds.enable {
    environment = {
      systemPackages = with pkgs; [ azahar ];
    };
  };
}

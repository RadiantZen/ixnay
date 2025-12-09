{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    ixnay.programs.create.drawio.enable = lib.mkEnableOption "drawio";
  };

  config = lib.mkIf config.ixnay.programs.create.drawio.enable {
    environment = {
      systemPackages = with pkgs; [ drawio ];
    };
  };
}

{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    ixnay.services.printer.sane.enable = lib.mkEnableOption "scanner service";
  };

  config = lib.mkIf config.ixnay.services.printer.sane.enable {
    hardware = {
      sane = {
        enable = true;
        brscan4.enable = true;
        brscan5.enable = true;
        extraBackends = with pkgs; [ sane-airscan ];
      };
    };
  };
}

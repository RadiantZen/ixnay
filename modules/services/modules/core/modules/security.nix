{ config, lib, ... }:

{
  options = {
    ixnay.services.core.security.enable = lib.mkEnableOption "system security";
  };

  config = lib.mkIf config.ixnay.services.core.security.enable {
    security = {
      polkit = {
        enable = true;
      };

      rtkit = {
        enable = true;
      };

      sudo = {
        enable = true;
        execWheelOnly = true;
        wheelNeedsPassword = true;
        extraConfig = ''
          Defaults lecture = never
        '';
      };
    };
  };
}

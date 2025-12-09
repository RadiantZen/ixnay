{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    ixnay.programs.vesktop.enable = lib.mkEnableOption "vesktop";
  };

  config = lib.mkIf config.ixnay.programs.vesktop.enable {
    environment = {
      systemPackages = with pkgs; [ vesktop ];
    };
  };
}

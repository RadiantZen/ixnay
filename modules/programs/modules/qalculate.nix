{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    ixnay.programs.qalculate.enable = lib.mkEnableOption "qalculate";
  };

  config = lib.mkIf config.ixnay.programs.qalculate.enable {
    environment = {
      systemPackages = with pkgs; [
        libqalculate
        qalculate-qt
      ];
    };
  };
}

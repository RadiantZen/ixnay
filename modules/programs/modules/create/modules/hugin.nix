{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    ixnay.programs.create.hugin.enable = lib.mkEnableOption "hugin";
  };

  config = lib.mkIf config.ixnay.programs.create.hugin.enable {
    environment = {
      systemPackages = with pkgs; [ hugin ];
    };
  };
}

{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    ixnay.programs.create.krita.enable = lib.mkEnableOption "krita";
  };

  config = lib.mkIf config.ixnay.programs.create.krita.enable {
    environment = {
      systemPackages = with pkgs; [ krita ];
    };
  };
}

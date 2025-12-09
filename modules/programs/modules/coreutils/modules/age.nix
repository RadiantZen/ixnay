{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    ixnay.programs.coreutils.age.enable = lib.mkEnableOption "age";
  };

  config = lib.mkIf config.ixnay.programs.coreutils.age.enable {
    environment = {
      systemPackages = with pkgs; [ age ];
    };
  };
}

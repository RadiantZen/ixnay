{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    ixnay.programs.coreutils.wget.enable = lib.mkEnableOption "wget";
  };

  config = lib.mkIf config.ixnay.programs.coreutils.wget.enable {
    environment = {
      systemPackages = with pkgs; [ wget ];
    };
  };
}

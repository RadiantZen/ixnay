{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    ixnay.programs.coreutils.btop.enable = lib.mkEnableOption "btop";
  };

  config = lib.mkIf config.ixnay.programs.coreutils.btop.enable {
    environment = {
      systemPackages = with pkgs; [ btop ];
    };
    # wrapper = {
    #   btop = {
    #     name = "btop-custom";
    #     basePackage = pkgs.btop;
    #   };
    # };
  };
}

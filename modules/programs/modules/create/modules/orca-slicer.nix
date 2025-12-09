{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    ixnay.programs.create.orca-slicer.enable = lib.mkEnableOption "orca-slicer";
  };

  config = lib.mkIf config.ixnay.programs.create.orca-slicer.enable {
    environment = {
      systemPackages = with pkgs; [ orca-slicer ];
    };
  };
}

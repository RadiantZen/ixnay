{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    ixnay.programs.coreutils.jq.enable = lib.mkEnableOption "jq";
  };

  config = lib.mkIf config.ixnay.programs.coreutils.jq.enable {
    environment = {
      systemPackages = with pkgs; [ jq ];
    };
  };
  # TODO Wrap colors
}

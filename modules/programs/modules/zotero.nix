{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    ixnay.programs.zotero.enable = lib.mkEnableOption "zotero";
  };

  config = lib.mkIf config.ixnay.programs.zotero.enable {
    environment = {
      systemPackages = with pkgs; [ zotero ];
    };
  };
}

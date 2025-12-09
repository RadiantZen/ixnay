{
  config,
  lib,
  pkgs,
  ...
}:

let
  port = "631";
in
{
  options = {
    ixnay.services.printer.cups.enable = lib.mkEnableOption "printing service";
  };

  config = lib.mkIf config.ixnay.services.printer.cups.enable {
    services = {
      printing = {
        enable = true;
        cups-pdf = {
          enable = true;
        };
        drivers = with pkgs; [
          # (pkgs.callPackage ../../../packages/dcpt820dw.nix {})
          # gutenprint
          # gutenprintBin
          # brlaser
          # brgenml1lpr
          # brgenml1cupswrapper
        ];
        listenAddresses = [ "localhost:${port}" ];
        stateless = true;
      };
    };
  };
}

{ config, lib, ... }:

let
  listNixModules =
    path:
    builtins.map (f: path + f) (
      builtins.map (f: "/" + f) (
        builtins.attrNames (
          lib.filterAttrs (n: v: lib.hasSuffix ".nix" n || v == "directory") (builtins.readDir path)
        )
      )
    );
in
{
  imports = listNixModules ./modules;

  options = {
    ixnay.services.printer.enable = lib.mkEnableOption "emulation";
  };

  config = lib.mkIf config.ixnay.services.printer.enable {
    ixnay.services.printer = {
      avahi.enable = lib.mkDefault true;
      cups.enable = lib.mkDefault true;
      sane.enable = lib.mkDefault true;
    };
  };
}

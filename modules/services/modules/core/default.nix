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
    ixnay.services.core.enable = lib.mkEnableOption "Core services";
  };

  config = lib.mkIf config.ixnay.services.core.enable {
    ixnay.services.core = {
      bootloader.enable = lib.mkDefault true;
      security.enable = lib.mkDefault true;
    };
  };
}

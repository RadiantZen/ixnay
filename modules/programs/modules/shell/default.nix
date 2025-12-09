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
    ixnay.programs.shell.enable = lib.mkEnableOption "shell";
  };

  config = lib.mkIf config.ixnay.programs.shell.enable {
    ixnay.programs.shell = {
      fish.enable = lib.mkDefault true;
    };
  };
}

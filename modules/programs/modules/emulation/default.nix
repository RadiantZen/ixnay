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
    ixnay.programs.emulation.enable = lib.mkEnableOption "emulation";
  };

  config = lib.mkIf config.ixnay.programs.emulation.enable {
    ixnay.programs.emulation = {
      mame.enable = lib.mkDefault true;
      n3ds.enable = lib.mkDefault true;
      psp.enable = lib.mkDefault true;
      switch.enable = lib.mkDefault true;
      wii.enable = lib.mkDefault true;
      wiiu.enable = lib.mkDefault true;
    };
  };
}

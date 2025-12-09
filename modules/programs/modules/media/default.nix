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
    ixnay.programs.media.enable = lib.mkEnableOption "media";
  };

  config = lib.mkIf config.ixnay.programs.media.enable {
    ixnay.programs.media = {
      imv.enable = lib.mkDefault true;
      mpv.enable = lib.mkDefault true;
      zathura.enable = lib.mkDefault true;
    };
  };
}

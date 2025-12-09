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
    ixnay.programs.create.enable = lib.mkEnableOption "create";
  };

  config = lib.mkIf config.ixnay.programs.create.enable {
    ixnay.programs.create = {
      blender.enable = lib.mkDefault true;
      darktable.enable = lib.mkDefault true;
      drawio.enable = lib.mkDefault true;
      ffmpeg.enable = lib.mkDefault true;
      freecad.enable = lib.mkDefault true;
      hugin.enable = lib.mkDefault true;
      imagemagick.enable = lib.mkDefault true;
      inkscape.enable = lib.mkDefault true;
      krita.enable = lib.mkDefault true;
      orca-slicer.enable = lib.mkDefault true;
    };
  };
}

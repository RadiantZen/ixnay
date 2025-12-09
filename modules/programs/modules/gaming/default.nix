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
    ixnay.programs.gaming.enable = lib.mkEnableOption "gaming";
  };

  config = lib.mkIf config.ixnay.programs.gaming.enable {
    ixnay.programs.gaming = {
      gamemode.enable = lib.mkDefault true;
      heroic.enable = lib.mkDefault true;
      itch.enable = lib.mkDefault true;
      mangohud.enable = lib.mkDefault true;
      prism-launcher.enable = lib.mkDefault true;
      steam.enable = lib.mkDefault true;
      vkbasalt.enable = lib.mkDefault true;
    };
  };
}

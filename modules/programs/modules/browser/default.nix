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
    ixnay.programs.browser.enable = lib.mkEnableOption "browser";
  };

  config = lib.mkIf config.ixnay.programs.browser.enable {
    ixnay.programs.browser = {
      chromium.enable = lib.mkDefault true;
      firefox.enable = lib.mkDefault true;
    };
  };
}

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
    ixnay.programs.coreutils.enable = lib.mkEnableOption "Coreutils";
  };

  config = lib.mkIf config.ixnay.programs.coreutils.enable {
    ixnay.programs.coreutils = {
      age.enable = lib.mkDefault true;
      bat.enable = lib.mkDefault true;
      benchmark.enable = lib.mkDefault true;
      btop.enable = lib.mkDefault true;
      direnv.enable = lib.mkDefault true;
      eza.enable = lib.mkDefault true;
      git.enable = lib.mkDefault true;
      jq.enable = lib.mkDefault true;
      less.enable = lib.mkDefault true;
      libarchive.enable = lib.mkDefault true;
      minisign.enable = lib.mkDefault true;
      mprocs.enable = lib.mkDefault true;
      rar.enable = lib.mkDefault true;
      search-tools.enable = lib.mkDefault true;
      tokei.enable = lib.mkDefault true;
      wget.enable = lib.mkDefault true;
      yazi.enable = lib.mkDefault true;
      zps.enable = lib.mkDefault true;
    };
  };
}

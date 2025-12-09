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
    ixnay.services.network.enable = lib.mkEnableOption "emulation";
  };

  config = lib.mkIf config.ixnay.services.network.enable {
    ixnay.services.network = {
      base.enable = lib.mkDefault true;
      dhcp.enable = lib.mkDefault true;
      dns.enable = lib.mkDefault true;
      firewall.enable = lib.mkDefault true;
      ntp.enable = lib.mkDefault true;
      ssh.enable = lib.mkDefault true;
      timezone.enable = lib.mkDefault true;
    };
  };
}

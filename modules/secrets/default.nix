let
  sources = import ../../npins;
in
{
  imports = [ (sources.sops-nix + "/modules/sops") ];

  sops = {
    defaultSopsFile = ./data/default.yaml;
    defaultSopsFormat = "yaml";

    # TODO Setup encryption based on host ssh key
    # TODO Move to host setup
    # NOTE Bootstrap ssh keys cant be in sops as it cant decrypt itself
    age = {
      keyFile = "/persist/ixnay/keychain/sops/radiantzen.key";
    };
  };
}

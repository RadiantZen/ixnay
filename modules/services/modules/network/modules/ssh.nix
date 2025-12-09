{ config, lib, ... }:

{
  options = {
    ixnay.services.network.ssh.enable = lib.mkEnableOption "ssh";
  };

  config = lib.mkIf config.ixnay.services.network.ssh.enable {
    programs = {
      ssh = {
        startAgent = true;
        agentTimeout = "1h";
        # knownHosts = {};
      };
    };

    services = {
      openssh = {
        enable = true;
        settings = {
          PermitRootLogin = "no";
          PasswordAuthentication = false;
          KbdInteractiveAuthentication = false;
        };
        ports = [
          22
          # 17382
        ];
        openFirewall = true;
      };
    };
  };
}

{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    ixnay.services.qbittorrent.enable = lib.mkEnableOption "qbittorrent";
  };

  config = lib.mkIf config.ixnay.services.qbittorrent.enable {
    # environment = {
    #   systemPackages = with pkgs; [ qbittorrent ];
    # };
    networking.firewall = {
      allowedTCPPorts = [ config.services.qbittorrent.torrentingPort ];
    };
    services = {
      qbittorrent = {
        enable = true;
        webuiPort = 19992;
        torrentingPort = 59443;
        extraArgs = [ "--confirm-legal-notice" ];
        serverConfig = {
          Application = {
            MemoryWorkingSetLimit = 8192;
          };

          BitTorrent = {
            Session = {
              AlternativeGlobalDLSpeedLimit = 2048;
              AlternativeGlobalUPSpeedLimit = 2048;
              Tags = "cross, civizo";
              TempPath = "/var/lib/qBittorrent/qBittorrent/downloads/.incomplete";
              TempPathEnabled = true;
              TorrentContentLayout = "Subfolder";
              UseUnwantedFolder = true;
            };
          };

          Preferences = {
            WebUI = {
              Password_PBKDF2 = "@ByteArray(uBMUBhJtEqmakzk/9mcPqg==:XomH8SaVgY0j7hRD8W/yotspg68MjBaTiCLsv5QDsE+rcpBmhewbejcyQQFn8DKEM6e9SoCNc2l5q2/gRxLmxQ==)";
              Username = "RadiantZen";
            };
          };

        };
      };

      # caddy = {
      #   virtualHosts = {
      #     "qbit.radiantzen.net" = {
      #       extraConfig = config.ixnay.services.caddy.reverseProxySSO "http://127.0.0.1:${builtins.toString config.services.qbittorrent.webuiPort}";
      #     };
      #   };
      # };
    };
  };
}

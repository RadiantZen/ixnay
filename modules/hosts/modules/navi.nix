{ config, lib, ... }:

{
  options = {
    ixnay.hosts.stonewall.enable = lib.mkEnableOption "stonewall host";
  };

  config = lib.mkIf config.ixnay.hosts.stonewall.enable {
    fileSystems = {
      "/" = {
        device = "trout/stonewall";
        fsType = "zfs";
        options = [ "zfsutil" ];
      };
      "/persist" = {
        device = "trout/stonewall/persist";
        fsType = "zfs";
        options = [ "zfsutil" ];
        neededForBoot = true;
      };
      "/boot" = {
        device = "/dev/disk/by-partlabel/boot-a";
        fsType = "vfat";
      };
      "/boot.backup" = {
        device = "/dev/disk/by-partlabel/boot-b";
        fsType = "vfat";
      };
    };

    ixnay = {
      services = {
        # caddy.enable = true;
        # jellyfin.enable = true;
        # miniflux.enable = true;
        # paperless.enable = true;
        # postgresql.enable = true;
        # qbittorrent.enable = true;
        # radicale.enable = true;
        # stirling-pdf.enable = true;
        # vaultwarden.enable = true;
        # vikunja.enable = true;
      };
      programs = {
        hyfetch.enable = true;
        yt-dlp.enable = true;
      };
    };
  };
}

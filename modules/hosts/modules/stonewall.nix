{ config, lib, ... }:

{
  options = {
    ixnay.hosts.stonewall.enable = lib.mkEnableOption "stonewall host";
  };

  config = lib.mkIf config.ixnay.hosts.stonewall.enable {
    boot = {
      initrd = {
        systemd = {
          services = {
            rollback = {
              name = "transient.zfs.rollback";
              description = "Rollback ZFS root datasets to a pristine state";
              wantedBy = [ "initrd.target" ];
              after = [ "zfs-import-trout.service" ];
              before = [ "sysroot.mount" ];
              serviceConfig = {
                Type = "oneshot";
              };
              unitConfig = {
                DefaultDependencies = "no";
              };
              path = [ config.boot.zfs.package ];
              script = ''
                zfs rollback -r trout/stonewall@blank
                zfs rollback -r trout/stonewall/etc@blank
                zfs rollback -r trout/stonewall/tmp@blank
                zfs rollback -r trout/stonewall/var@blank
                zfs rollback -r trout/stonewall/var/lib@blank
                echo ">> >> rollback complete << <<"
              '';
            };
          };
        };
        secrets = {
          "/run/keys/zfs/muse" = "/persist/ixnay/keychain/zfs/muse";
          "/run/keys/zfs/stonewall" = "/persist/ixnay/keychain/zfs/stonewall";
        };
      };
      zfs = {
        extraPools = [
          "pond"
          "trout"
        ];
      };
    };

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

    environment = {
      etc = {
        "machine-id" = {
          source = "/persist/ixnay/keychain/machine-id/stonewall";
        };
        "ssh/ssh_host_rsa_key" = {
          source = "/persist/ixnay/keychain/ssh/stonewall/ssh_host_rsa_key";
        };
        "ssh/ssh_host_rsa_key.pub" = {
          source = "/persist/ixnay/keychain/ssh/stonewall/ssh_host_rsa_key.pub";
        };
        "ssh/ssh_host_ed25519_key" = {
          source = "/persist/ixnay/keychain/ssh/stonewall/ssh_host_ed25519_key";
        };
        "ssh/ssh_host_ed25519_key.pub" = {
          source = "/persist/ixnay/keychain/ssh/stonewall/ssh_host_ed25519_key.pub";
        };
        "zfs/zpool.cache" = {
          source = "/persist/etc/zfs/zpool.cache";
        };
      };
    };

    swapDevices = [
      {
        device = "/dev/disk/by-partlabel/swap-a";
        priority = 1;
        randomEncryption = {
          enable = true;
          allowDiscards = true;
        };
      }
    ];

    zramSwap = {
      writebackDevice = "/dev/disk/by-partlabel/zramwbd";
    };

    systemd.network = {
      networks = {
        "120-stonewall" = {
          matchConfig = {
            Type = "ether";
          };
          networkConfig = {
            DHCP = "no";
          };
          addresses = [
            { Address = "157.180.62.125/26"; }
            { Address = "2a01:4f9:3100:4928::/64"; }
          ];
          gateway = [
            "157.180.62.65"
            "fe80::1"
          ];
          linkConfig.RequiredForOnline = "routable";
        };
      };
    };

    ixnay = {
      services = {
        network.dhcp.enable = false;
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
      machines = {
        hetzner.sx65.enable = true;
      };
      programs = {
        hyfetch.enable = true;
        yt-dlp.enable = true;
      };
    };
  };
}

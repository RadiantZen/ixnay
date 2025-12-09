let
  predef = import ./datasets.nix;
in
let
  sources = import ./npins;
  pkgs = import sources.nixpkgs { };
  lib = pkgs.lib;

  topology = {
    partitions = {
      "nvme-SAMSUNG_MZVLB1T0HALR-00000_S3W6NX0M501730" = {
        label = "gpt";
        partition = {
          part1 = {
            no = "1";
            label = "boot-a";
            start = "0%";
            end = "4GiB";
            filesystem = "fat32";
            flags = {
              boot = "on";
            };
          };
          part2 = {
            no = "2";
            label = "zramwbd";
            start = "4GiB";
            end = "36GiB";
            filesystem = "ext4";
            flags = { };
          };
          part3 = {
            no = "3";
            label = "main";
            start = "36GiB";
            end = "100%";
            filesystem = "ext4";
            flags = { };
          };
        };
      };
      "nvme-SAMSUNG_MZVLB1T0HALR-00000_S3W6NX0M507628" = {
        label = "gpt";
        partition = {
          part1 = {
            no = "1";
            label = "boot-b";
            start = "0%";
            end = "4GiB";
            filesystem = "fat32";
            flags = {
              boot = "on";
            };
          };
          part2 = {
            no = "2";
            label = "swap-a";
            start = "4GiB";
            end = "36GiB";
            filesystem = "linux-swap";
            flags = {
              swap = "on";
            };
          };
          part3 = {
            no = "3";
            label = "main";
            start = "36GiB";
            end = "100%";
            filesystem = "ext4";
            flags = { };
          };
        };
      };
    };

    zfs = {
      pond = {
        topology = {
          vdev1 = {
            type = "default";
            parity = "mirror";
            disks = [
              "ata-ST22000NM002E-3HL113_ZX27C0G8"
              "ata-ST22000NM002E-3HL113_ZX27N9WR"
            ];
          };
          vdev2 = {
            type = "default";
            parity = "mirror";
            disks = [
              "ata-ST22000NM002E-3HL113_ZX27ZJ14"
              "ata-ST22000NM002E-3HL113_ZX2898RN"
            ];
          };
        };

        datasets = predef.muse;

        pool_properties = {
          ashift = "12";
        };

        filesystem_properties = {
          aclinherit = "passthrough";
          acltype = "posix";
          checksum = "blake3";
          "com.sun:auto-snapshot" = "true";
          compression = "zstd";
          dnodesize = "auto";
          longname = "on";
          normalization = "formD";
          xattr = "sa";
        };
      };

      trout = {
        topology = {
          vdev1 = {
            type = "default";
            parity = "mirror";
            disks = [
              "nvme-SAMSUNG_MZVLB1T0HALR-00000_S3W6NX0M501730-part3"
              "nvme-SAMSUNG_MZVLB1T0HALR-00000_S3W6NX0M507628-part3"
            ];
          };
        };

        datasets = predef.stonewall;

        pool_properties = {
          ashift = "12";
        };

        filesystem_properties = {
          aclinherit = "passthrough";
          acltype = "posix";
          checksum = "blake3";
          "com.sun:auto-snapshot" = "true";
          compression = "zstd";
          dnodesize = "auto";
          longname = "on";
          normalization = "formD";
          xattr = "sa";
        };
      };
    };
  };

in
let
  partitionDisk = lib.attrsets.mapAttrsToList (disk: value: [
    "\n"
    "parted"
    (lib.concatStrings [
      "/dev/disk/by-id/"
      disk
    ])
    "--script"
    "mklabel"
    value.label
    (lib.mapAttrsToList (name: value: [
      "mkpart"
      value.label
      value.filesystem
      value.start
      value.end
      (lib.mapAttrsToList (flag: state: [
        "set"
        value.no
        flag
        state
      ]) value.flags)
    ]) value.partition)

  ]) topology.partitions;

  zpoolCreate = lib.attrsets.mapAttrsToList (pool: value: [
    "\n"
    "zpool create -f"
    pool
    (lib.mapAttrsToList (name: value: [
      "-o"
      (lib.concatStrings [
        name
        "="
        value
      ])
    ]) value.pool_properties)
    (lib.mapAttrsToList (name: value: [
      "-O"
      (lib.concatStrings [
        name
        "="
        value
      ])
    ]) value.filesystem_properties)
    (lib.mapAttrsToList (name: value: [
      (lib.optional (value.type != "default") value.type)
      value.parity
      value.disks
    ]) value.topology)
  ]) topology.zfs;

  zpoolUpdate = lib.attrsets.mapAttrsToList (pool: value: [
    (lib.mapAttrsToList (name: value: [
      "\n"
      "zpool set"
      (lib.concatStrings [
        name
        "="
        value
      ])
      pool
    ]) value.pool_properties)
    (lib.mapAttrsToList (name: value: [
      "\n"
      "zpool set"
      (lib.concatStrings [
        name
        "="
        value
      ])
      pool
    ]) value.filesystem_properties)
  ]) topology.zfs;

  zfsDatasetCreate = lib.attrsets.mapAttrsToList (pool: value: [
    (lib.mapAttrsToList (name: value: [
      "\n"
      "zfs create"
      (lib.concatStrings [
        pool
        "/"
        name
      ])
      (lib.mapAttrsToList (name: value: [
        "-o"
        (lib.concatStrings [
          name
          "="
          value
        ])
      ]) value.props)
      (lib.optional (value.blankSnapshot) [
        "\n"
        "zfs snapshot"
        (lib.concatStrings [
          pool
          "/"
          name
          "@blank"
        ])
      ])
    ]) value.datasets)
  ]) topology.zfs;

in
pkgs.writeShellScriptBin "disko" ''
  main () {
      shell_setup
      partition_disks
      zfs_setup_pool
      zfs_setup_datasets
      post_command
  }

  shell_setup () {
      set -euo pipefail
      trap finish EXIT
      IFS=$'\n\t'
  }

  finish () {
      echo "Script exited or terminated!"
  }

  partition_disks () {
      echo "Partitioning Disks"
      ${builtins.toString partitionDisk}
  }

  zfs_setup_pool () {
      echo "Zpool Creation"
      ${builtins.toString zpoolCreate}
  }

  zfs_setup_datasets () {
      echo "ZFS dataset create"
      ${builtins.toString zfsDatasetCreate}
  }

  post_command () {
      echo "Post Command"
      mkfs.fat -F32 /dev/disk/by-partlabel/boot-a
      mkfs.fat -F32 /dev/disk/by-partlabel/boot-b
      mkswap /dev/disk/by-partlabel/swap-a

      mkdir /trout/stonewall/persist/etc
      mkdir /trout/stonewall/persist/etc/zfs
      zfs set mountpoint=/mnt trout/stonewall

      mkdir /mnt/boot
      mount /dev/disk/by-partlabel/boot-a /mnt/boot
  }

  main
  echo "Success"
''

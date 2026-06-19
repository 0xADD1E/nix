# Copyright © 2025 Casey Link <casey@outskirtslabs.com>
# SPDX-License-Identifier: MIT
#
# Overlay Filesystem for /nix/var/nix/db in microvm.nix
#
# Background Problem:
# When using microvm.nix with a shared /nix/store from the host, the guest VM's Nix
# database doesn't know about the store paths that exist. This causes commands like
# `nix-store --realise` and home-manager activation to fail with "don't know how to
# build these paths" errors, even though the paths exist in the shared store.
#
# The conventional solution is to dump the host's Nix database and load it in the
# guest at boot time, but this adds several minutes to VM startup time.
#
# Motivation:
# We need a fast way to give the guest VM access to the host's Nix database entries
# while still allowing the guest to register its own store paths on the host. The boot time
# penalty of dump/load is unacceptable for development workflows.
#
# Solution:
# This module implements an overlayfs mount for /nix/var/nix/db, complementing the
# overlayfs for /nix/store that microvm.nix already provides. The guest starts with
# the same database as the host (via the lower layer) but can write its own entries
# to the upper layer.
#
# This "overlay everything" approach is discussed in the local-overlay-store RFC [0].
#
# The RFC authors moved away from this approach because new additions to the host's
# store aren't visible to guests (they have divergent SQLite databases). However,
# for our use case this limitation is acceptable - we don't need dynamic visibility
# of new host store paths in running guests.
#
# This approach is significantly faster than database dump/load and has been working
# well in practice, as noted by Replit who used it before developing local-overlay-store.
#
# [0]: https://github.com/NixOS/rfcs/pull/152
#
{ config
, lib
, ...
}:

let
  defaultShareProto = "virtiofs";
  rwStore = "/nix/.rw-store";
  roVarDB = "/nix/.ro-var-nix-db";
  rwVarDB = "/nix/.rw-var-nix-db";
in
{
  config = {
    microvm = {
      writableStoreOverlay = rwStore;
      preStart = ''
        rm -f nix-store-overlay.img
        rm -f nix-var-overlay.img
      '';
      shares = [
        # Host nix store share
        {
          proto = defaultShareProto;
          tag = "ro-store";
          source = "/nix/store";
          mountPoint = "/nix/.ro-store";
        }
        {
          proto = defaultShareProto;
          tag = "ro-var-nix-db";
          source = "/nix/var/nix/db";
          mountPoint = "/nix/.ro-var-nix-db";
        }
      ];
      volumes = [
        {
          image = "nix-store-overlay.img";
          mountPoint = rwStore;
          size = 8 * 1024;
        }
        {
          image = "nix-var-overlay.img";
          mountPoint = rwVarDB;
          size = 1 * 1024;
        }
      ];
    };

    #systemd.services.rw-var-nix-db = {
    #    unitConfig = {
    #      DefaultDependencies = false;
    #      RequiresMountsFor = "${rwVarDB}";
    #    };
    #    script = ''
    #      /bin/mkdir -p -m 0755 ${rwVarDB}/var/nix/db {rwVarDB}/work /nix/var/nix/db
    #      # While our non-root user running the microvm can read the db, they cannot read the big-lock nor reserved files
    #      # which are 0600 on the host, so we shadow them in the upperdir
    #      /bin/touch ${rwVarDB}/var/nix/db/big-lock
    #      /bin/chmod 600 ${rwVarDB}/var/nix/db/big-lock
    #      /bin/touch ${rwVarDB}/var/nix/db/reserved
    #      /bin/chmod 600 ${rwVarDB}/var/nix/db/reserved
    #    '';
    #    serviceConfig = {
    #      Type = "oneshot";
    #    };
    #  };

    fileSystems = {
      ${roVarDB} = {
        neededForBoot = true;
      };
      ${rwVarDB} = {
        neededForBoot = true;
      };
      "/nix/var/nix/db" = {
        neededForBoot = true;
        overlay = {
          lowerdir = [ roVarDB ];
          upperdir = "${rwVarDB}/var/nix/db";
          workdir = "${rwVarDB}/work";
        };
        options = [
          "userxattr"
          #"x-systemd.requires=rw-var-nix-db.service"
        ];
        depends = [
          "/nix/.ro-store"
          "/nix/.rw-store"
          "/nix/.ro-var-nix-db"
          "/nix/.rw-var-nix-db"
        ];
      };
    };
    systemd.mounts = [{
      what = "db";
      where = "/nix/var/nix/db";
      overrideStrategy = "asDropin";
      unitConfig.DefaultDependencies = false;
    }];
  };
}

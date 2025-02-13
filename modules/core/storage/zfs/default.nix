{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.musselwhite-dev.core = {
    persistence = {
      enable = lib.mkEnableOption "Enable persistence";
    };

    zfs = {
      # Enable ZFS
      enable = lib.mkEnableOption "zfs";
      # Ask for credentials
      encrypted = lib.mkEnableOption "zfs request credentials";

      # Clear our symbolic links
      systemCacheLinks = lib.mkOption { default = [ ]; };
      systemDataLinks = lib.mkOption { default = [ ]; };
      homeCacheLinks = lib.mkOption { default = [ ]; };
      homeDataLinks = lib.mkOption { default = [ ]; };

      ensureSystemExists = lib.mkOption {
        default = [ ];
        example = [ "/data/etc/ssh" ];
      };
      ensureHomeExists = lib.mkOption {
        default = [ ];
        example = [ ".ssh" ];
      };
      rootDataset = lib.mkOption {
        default = "";
        example = "rpool/local/root";
      };
    };
  };

  config = {
    musselwhite-dev = {
      core = {
        persistence = {
          enable = lib.mkDefault true;
        };
        zfs = {
          enable = lib.mkDefault true;
        };
      };

      dataPrefix = lib.mkDefault "/data";
      cachePrefix = lib.mkDefault "/cache";
    };

    environment.persistence."${config.musselwhite-dev.cachePrefix}" = {
      hideMounts = true;
      directories = config.musselwhite-dev.core.zfs.systemCacheLinks;
      users.jon.directories = config.musselwhite-dev.core.zfs.homeCacheLinks;
    };

    environment.persistence."${config.musselwhite-dev.dataPrefix}" = {
      hideMounts = true;
      directories = config.musselwhite-dev.core.zfs.systemDataLinks;
      users.jon.directories = config.musselwhite-dev.core.zfs.homeDataLinks;
    };

    boot = {
      supportedFilesystems = [ "zfs" ];
      zfs = {
        devNodes = "/dev/";
        requestEncryptionCredentials = config.musselwhite-dev.core.zfs.encrypted;
      };
      initrd.postDeviceCommands = lib.mkAfter ''
        zfs rollback -r ${config.musselwhite-dev.core.zfs.rootDataset}@blank
      '';
    };

    services = {
      zfs = {
        autoScrub.enable = true;
        trim.enable = true;
      };
    };

    environment.systemPackages = [
      (pkgs.writeScriptBin "zfsdiff" ''
        doas zfs diff ${config.musselwhite-dev.core.zfs.rootDataset}@blank -F | ${pkgs.ripgrep}/bin/rg -e "\+\s+/\s+" | cut -f3- | ${pkgs.skim}/bin/sk --query "/home/jon/"
      '')
    ];

    system.activationScripts =
      let
        ensureSystemExistsScript = lib.concatStringsSep "\n" (
          map (path: ''mkdir -p "${path}"'') config.musselwhite-dev.core.zfs.ensureSystemExists
        );
        ensureHomeExistsScript = lib.concatStringsSep "\n" (
          map (path: ''
            mkdir -p "/home/jon/${path}"; chown jon:users /home/jon/${path}
          '') config.musselwhite-dev.core.zfs.ensureHomeExists
        );
      in
      {
        ensureSystemPathsExist = {
          text = ensureSystemExistsScript;
          deps = [ ];
        };
        ensureHomePathsExist = {
          text = ''
            mkdir -p /home/jon/
            ${ensureHomeExistsScript}
          '';
          deps = [
            "users"
            "groups"
          ];
        };
      };
  };
}

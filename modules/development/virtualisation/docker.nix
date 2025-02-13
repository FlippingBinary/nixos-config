{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    musselwhite-dev = {
      development.virtualisation = {
        docker.enable = lib.mkEnableOption "docker";
      };
    };
  };

  config = lib.mkIf config.musselwhite-dev.development.virtualisation.docker.enable {
    musselwhite-dev.core.zfs.systemCacheLinks = [ "/opt/docker" ];

    virtualisation.docker = {
      enable = true;
      extraOptions = "--data-root ${config.musselwhite-dev.dataPrefix}/var/lib/docker";
      storageDriver = "zfs";
    };

    home-manager.users.jon = {
      home.packages = with pkgs; [
        docker-compose
      ];
    };
    users.users.jon.extraGroups = [ "docker" ];
  };
}

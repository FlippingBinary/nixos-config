{
  config,
  lib,
  ...
}:
{
  config = {
    musselwhite-dev.core.zfs = lib.mkMerge [
      (lib.mkIf config.musselwhite-dev.core.persistence.enable {
        homeDataLinks = [
          {
            directory = ".ssh";
            mode = "0700";
          }
        ];
        systemDataLinks = [
          {
            directory = "/root/.ssh/";
            mode = "0700";
          }
        ];
      })
      (lib.mkIf (!config.musselwhite-dev.core.persistence.enable) { })
    ];

    # TODO: Configure SSH Agent
    home-manager.users.jon = _: {
      programs.ssh = {
        enable = true;
        hashKnownHosts = true;
        userKnownHostsFile =
          if config.musselwhite-dev.core.persistence.enable then
            "${config.musselwhite-dev.dataPrefix}/home/jon/.ssh/known_hosts"
          else
            "/home/jon/.ssh/known_hosts";
        extraOptionOverrides = {
          AddKeysToAgent = "yes";
          IdentityFile =
            if config.musselwhite-dev.core.persistence.enable then
              "${config.musselwhite-dev.dataPrefix}/home/jon/.ssh/id_ed25519"
            else
              "/home/jon/.ssh/id_ed25519";
        };
      };

      services = {
        ssh-agent = {
          enable = true;
        };
      };
    };
  };
}

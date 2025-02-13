{
  config,
  lib,
  ...
}:
{
  config = {
    musselwhite-dev.core.zfs = lib.mkMerge [
      (lib.mkIf config.musselwhite-dev.core.persistence.enable {
        ensureSystemExists = [ "${config.musselwhite-dev.dataPrefix}/etc/ssh" ];
      })
      (lib.mkIf (!config.musselwhite-dev.core.persistence.enable) { })
    ];

    services.openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "prohibit-password";

        # Remove stale sockets
        StreamLocalBindUnlink = "yes";
      };

      hostKeys = [
        {
          bits = 4096;
          path =
            if config.musselwhite-dev.core.persistence.enable then
              "${config.musselwhite-dev.dataPrefix}/etc/ssh/ssh_host_rsa_key"
            else
              "/etc/ssh/ssh_host_rsa_key";
          type = "rsa";
        }
        {
          bits = 4096;
          path =
            if config.musselwhite-dev.core.persistence.enable then
              "${config.musselwhite-dev.dataPrefix}/etc/ssh/ssh_host_ed25519_key"
            else
              "/etc/ssh/ssh_host_ed25519";
          type = "ed25519";
        }
      ];
    };
  };
}

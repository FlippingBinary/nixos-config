{
  config,
  lib,
  ...
}:
{
  options.musselwhite-dev.core.wireless.enable = lib.mkEnableOption "wireless";

  config = lib.mkIf config.musselwhite-dev.core.wireless.enable {
    networking.wireless = {
      enable = true;
      environmentFile = config.sops.secrets.wireless.path;
      networks = {
        "@home_uuid@" = {
          psk = "@home_psk@";
        };
      };
    };
  };
}

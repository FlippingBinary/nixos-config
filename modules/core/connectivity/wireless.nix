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
        "ext:uuid" = {
          psk = "ext:password";
        };
      };
    };
  };
}

{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.musselwhite-dev.development.yamlls.enable = lib.mkEnableOption "yamlls";

  config = lib.mkIf config.musselwhite-dev.development.yamlls.enable {
    home-manager.users.jon = {
      home.packages = with pkgs; [
        yaml-language-server
      ];
    };
  };
}

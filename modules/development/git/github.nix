{
  lib,
  config,
  ...
}:
let
  base = home: {
    programs.gh = {
      enable = true;
      settings = {
        editor = "nvim";
        git_protocol = "ssh";
      };
    };
  };
in
{
  musselwhite-dev.core.zfs = lib.mkMerge [
    (lib.mkIf config.musselwhite-dev.core.persistence.enable {
      homeCacheLinks = [ ".gh" ];
    })
    (lib.mkIf (!config.musselwhite-dev.core.persistence.enable) { })
  ];

  home-manager.users.jon = { ... }: (base "/home/jon");
}

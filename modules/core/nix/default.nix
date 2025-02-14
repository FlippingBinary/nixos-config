{
  config,
  lib,
  ...
}:
{
  options = {
    musselwhite-dev.core.nix = {
      enableDirenv = lib.mkOption { default = true; };
      unfreePackages = lib.mkOption {
        default = [ ];
      };
    };
  };

  config = {
    musselwhite-dev.core.zfs = lib.mkMerge [
      (lib.mkIf config.musselwhite-dev.core.persistence.enable {
        homeCacheLinks = [ "local/share/direnv" ];
        systemCacheLinks = [ "/root/.local/share/direnv" ];
        systemDataLinks = [ "/var/lib/nixos" ];
      })
      (lib.mkIf (!config.musselwhite-dev.core.persistence.enable) { })
    ];

    programs.nh = {
      enable = true;
      clean.enable = false;
      flake = "/home/jon/repos/nixos-config";
    };

    nixpkgs.config = {
      allowUnfree = true;
    };

    nix = {
      settings = {
        auto-optimize-store = true;
        trusted-users = [
          "jon"
        ];
        experimental-features = [
          "nix-command"
          "flakes"
        ];
        warn-dirty = false;
      };

      gc = {
        automatic = true;
        dates = "daily";
        options = "--delete-older-than 14d";
      };
    };
  };
}

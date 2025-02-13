{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = {
    musselwhite-dev.core.zfs = lib.mkMerge [
      (lib.mkIf config.musselwhite-dev.core.persistence.enable {
        homeDataLinks = [
          {
            directory = ".gnupg";
            mode = "0700";
          }
        ];
      })
      (lib.mkIf (!config.musselwhite-dev.core.persistence.enable) { })
    ];

    environment = {
      systemPackages = with pkgs; [
        gnupg
        pinentry-gtk2
      ];
    };

    home-manager.users.jon = {
      services.gpg-agent = {
        enable = true;
        enableZshIntegration = true;
        enableSshSupport = true;
        pinentryPackage = pkgs.pinentry-gtk2;
        defaultCacheTtl = 46000;
        extraConfig = ''
          allow-preset-passphrase
        '';
      };
    };
  };
}

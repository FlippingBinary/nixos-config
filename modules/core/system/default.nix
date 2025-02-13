{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.musselwhite-dev = {
    stateVersion = lib.mkOption {
      example = "23.11";
    };

    dataPrefix = lib.mkOption {
      example = "/data";
    };

    cachePrefix = lib.mkOption {
      example = "/cache";
    };
  };

  config = {
    system = {
      stateVersion = config.musselwhite-dev.stateVersion;
      autoUpgrade = {
        enable = lib.mkDefault true;
        flake = "github:FlippingBinary/nixos-config";
        dates = "01/04:00";
        randomizedDelaySec = "15min";
      };
    };
    environment = {
      systemPackages = with pkgs; [
        wget
        curl
        coreutils
        direnv
        dnsutils
        lshw
        moreutils
        usbutils
        nmap
        util-linux
        whois
        unzip
        git
        age
        sops
        ssh-to-age
        fastfetch
        tlrc
        jq
        yq
        fd
        openssl
        tcpdump
        bridge-utils
      ];
    };

    security = {
      sudo = {
        enable = false;
      };

      doas = {
        enable = true;
        extraRules = [
          {
            users = [ "jon" ];
            noPass = true;
          }
        ];
      };

      polkit = {
        enable = true;
      };
    };

    services = {
      fwupd = {
        enable = true;
      };
    };

    time = {
      timeZone = lib.mkDefault "America/New_York";
    };

    i18n = {
      defaultLocale = "en_IE.UTF-8";
      extraLocaleSettings = {
        LC_ALL = "en_IE.UTF-8";
        LANGUAGE = "en_US.UTF-8";
        LC_TIME = "en_GB.UTF-8";
      };
      supportedLocales = [
        "en_GB.UTF-8/UTF-8"
        "en_IE.UTF-8/UTF-8"
        "en_US.UTF-8/UTF-8"
      ];
    };
  };
}

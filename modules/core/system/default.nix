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
        extraRules = [{
          commands = [
            {
              command = "*";
              options = [ "NOPASSWD" ];
            }
          ];
          groups = [ "wheel" ];
        }];
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
      defaultLocale = "en_US.UTF-8";
      extraLocaleSettings = {
        LANGUAGE = "en_US.UTF-8";
        LC_ADDRESS = "en_US.UTF-8";
        LC_ALL = "en_IE.UTF-8";
        LC_IDENTIFICATION = "en_US.UTF-8";
        LC_MEASUREMENT = "en_US.UTF-8";
        LC_MONETARY = "en_US.UTF-8";
        LC_NAME = "en_US.UTF-8";
        LC_NUMERIC = "en_US.UTF-8";
        LC_PAPER = "en_US.UTF-8";
        LC_TELEPHONE = "en_US.UTF-8";
        LC_TIME = "en_US.UTF-8";
      };
      supportedLocales = [
        "en_US.UTF-8/UTF-8"
      ];
    };
  };
}

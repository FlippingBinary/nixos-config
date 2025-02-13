{ ... }:
{
  imports = [ ./hardware.nix ];

  networking = {
    hostName = "cougar-hyperv";
    hostId = "21b76857";
    nameservers = [
      "10.1.1.1"
      "1.1.1.1"
      "1.0.0.1"
    ];
  };

  musselwhite-dev = {
    stateVersion = "24.05";
    core = {
      zfs = {
        enable = true;
        encrypted = true;
        rootDataset = "rpool/local/root";
      };
      wireless = {
        enable = true;
      };
      routing = {
        enable = false;
      };
    };
    graphical = {
      enable = true;
      laptop = true;
      hyprland = {
        enable = true;
      };
      xdg = {
        enable = true;
      };
    };
  };
}

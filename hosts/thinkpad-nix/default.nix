{
  inputs,
  lib,
  ...
}:
{
  imports = [
    inputs.nixos-wsl.nixosModules.default
  ];

  wsl = {
    enable = true;

    defaultUser = "jon";
  };

  networking = {
    hostName = "thinkpad-nix";
    hostId = "765aac61";
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  musselwhite-dev = {
    stateVersion = "24.05";
    core = {
      persistence = {
        enable = false;
      };
      zfs = {
        enable = false;
      };
    };
    development = {
      virtualisation = {
        hypervisor = {
          enable = false;
        };
        docker = {
          enable = false;
        };
      };
    };
  };
}

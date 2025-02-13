{ lib, ... }:
{
  imports = [
    ./git
    ./yaml
    ./virtualisation
  ];

  config = {
    musselwhite-dev.development = {
      git.enable = lib.mkDefault true;
      yamlls.enable = lib.mkDefault true;
      virtualisation = {
        docker.enable = lib.mkDefault false;
        k8s.enable = lib.mkDefault false;
        hypervisor.enable = lib.mkDefault false;
      };
    };
  };
}

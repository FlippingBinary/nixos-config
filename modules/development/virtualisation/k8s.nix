{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    musselwhite-dev.development.virtualisation = {
      k8s.enable = lib.mkEnableOption "k8s tooling";
    };
  };

  config = lib.mkIf config.musselwhite-dev.development.virtualisation.k8s.enable {
    home-manager.users.jon = {
      home.packages = with pkgs; [
        talosctl
        kubectl
        kubernetes-helm
        kustomize
        argocd
        cilium-cli
        kubeseal
      ];

      programs.k9s = {
        enable = true;
        catppuccin = {
          enable = true;
          flavor = "macchiato";
        };
      };
    };
  };
}

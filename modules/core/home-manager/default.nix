{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    inputs.nix-colors.homeManagerModules.default
  ];

  musselwhite-dev.core.zfs = lib.mkMerge [
    (lib.mkIf config.musselwhite-dev.core.persistence.enable {
      homeCacheLinks = [
        ".config"
        ".cache"
        ".local"
        ".cloudflared"
      ];
    })
    (lib.mkIf (!config.musselwhite-dev.core.persistence.enable) { })
  ];

  colorScheme = inputs.nix-colors.colorSchemes.catppuccin-macchiato;
  catppuccin = {
    flavor = "macchiato";
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    users = {
      jon =
        { ... }:
        {
          imports = [
            inputs.catppuccin.homeManagerModules.catppuccin
          ];
          home = {
            stateVersion = config.musselwhite-dev.stateVersion;
            packages = [
              inputs.nixvim.packages.x86_64-linux.default
              pkgs.cloudflared
              pkgs.just
            ];
          };
          systemd.user.sessionVariables = config.home-manager.users.jon.home.sessionVariables;
          catppuccin = {
            flavor = "macchiato";
            accent = "peach";
          };
        };
      root = _: { home.stateVersion = config.musselwhite-dev.stateVersion; };
    };
  };
}

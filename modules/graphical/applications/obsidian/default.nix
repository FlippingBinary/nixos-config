{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.musselwhite-dev.graphical.applications.obsidian.enable = lib.mkEnableOption "obsidian";

  config = lib.mkIf config.musselwhite-dev.graphical.applications.obsidian.enable {
    environment.systemPackages = with pkgs; [
      obsidian
    ];
  };
}

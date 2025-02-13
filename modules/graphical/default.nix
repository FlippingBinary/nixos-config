{
  config,
  lib,
  ...
}:
{
  imports = [
    ./desktop
    ./xdg
    ./terminal
    ./theme
    ./applications
    ./sound
  ];

  options.musselwhite-dev.graphical = {
    enable = lib.mkEnableOption "graphical environment";
    laptop = lib.mkEnableOption "laptop configuration";
  };

  # TODO: Create a nicer options structure
  config = lib.mkIf config.musselwhite-dev.graphical.enable {
    musselwhite-dev = {
      graphical = {
        hyprland.enable = lib.mkDefault true;
        hyprlock.enable = lib.mkDefault true;
        hyprpaper.enable = lib.mkDefault true;
        waybar.enable = lib.mkDefault true;
        swaync.enable = lib.mkDefault true;
        terminal.enable = lib.mkDefault true;
        xdg.enable = lib.mkDefault true;
        fuzzel.enable = lib.mkDefault true;
        key_management.enable = lib.mkDefault true;
        theme.enable = lib.mkDefault true;
        sound.enable = lib.mkDefault true;
        applications = {
          firefox.enable = lib.mkDefault true;
          obsidian.enable = lib.mkDefault true;
        };
      };
    };
  };
}

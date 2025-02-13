{
  config,
  lib,
  ...
}:
{
  options.musselwhite-dev.graphical.hyprpaper = {
    enable = lib.mkEnableOption "hyprpaper";
  };

  config = lib.mkIf config.musselwhite-dev.graphical.hyprpaper.enable {
    home-manager.users.jon = {
      home.file.".config/hypr/hyprpaper.conf".text = ''
        preload = ${/. + ../_assets/wallpaper.jpg}
        wallpaper = ,${/. + ../_assets/wallpaper.jpg}
        splash = false
      '';
    };
  };
}

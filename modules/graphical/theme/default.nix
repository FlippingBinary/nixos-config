{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.musselwhite-dev.graphical.theme = {
    enable = lib.mkOption {
      default = true;
    };
  };

  config = lib.mkIf config.musselwhite-dev.graphical.theme.enable {
    fonts = {
      enableDefaultPackages = true;
      fontDir = {
        enable = true;
      };
      fontconfig = {
        enable = true;
        defaultFonts = {
          monospace = [ "0xProto Nerd Font" ];
          sansSerif = [ "0xProto Nerd Font" ];
          serif = [ "0xProto Nerd Font" ];
        };
      };
      packages = with pkgs; [
        (nerdfonts.override { fonts = [ "0xProto" ]; })
      ];
    };

    programs.dconf.enable = true;

    home-manager.users.jon =
      { pkgs, ... }:
      {
        catppuccin = {
          yazi = {
            enable = true;
          };
          starship = {
            enable = true;
          };
          lazygit = {
            enable = true;
          };
          fzf = {
            enable = true;
          };
          bottom = {
            enable = true;
          };
          bat = {
            enable = true;
          };
          pointerCursor = {
            enable = true;
            accent = "dark";
            flavor = "macchiato";
          };
        };

        gtk = {
          enable = true;
          gtk2.extraConfig = "gtk-application-prefer-dark-theme = true;";
          gtk3.extraConfig.gtk-application-prefer-dark-theme = true;

          font = {
            name = "0xProto Nerd Font";
            size = 10;
          };

          catppuccin = {
            flavor = "macchiato";
            accent = "peach";
            size = "compact";
            #icon = {
            #  enable = true;
            #  flavor = "macchiato";
            #  accent = "peach";
            #};
          };
        };

        qt = {
          enable = true;
          platformTheme.name = "gtk";
        };
      };
  };
}

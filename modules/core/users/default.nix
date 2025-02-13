{config, pkgs, ...}: {
  config = {
    users = {
      mutableUsers = false;
      users = {
        jon = {
          isNormalUser = true;
          home = "/home/jon";
          extraGroups = ["systemd-journal"];
          hashedPasswordFile = config.sops.secrets."users/jon".path;
        };
        root.hashedPasswordFile = config.sops.secrets."users/root".path;
      };
    };
  };
}

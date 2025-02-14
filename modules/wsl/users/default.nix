_: {
  users = {
    mutableUsers = true;
    users = {
      jon = {
        isNormalUser = true;
        home = "/home/jon";
        extraGroups = [
          "systemd-journal"
          "wheel"
        ];
      };
      fwupd-refresh = {
        isSystemUser = true;
        uid = 998;
      };
      nscd = {
        isSystemUser = true;
        uid = 999;
      };
      sshd = {
        isSystemUser = true;
        uid = 997;
      };
    };
    groups = {
      fwupd-refresh = {
        gid = 997;
      };
      nscd = {
        gid = 999;
      };
      polkituser = {
        gid = 996;
      };
      sshd = {
        gid = 995;
      };
      systemd-coredump = {
        gid = 998;
      };
    };
  };
}

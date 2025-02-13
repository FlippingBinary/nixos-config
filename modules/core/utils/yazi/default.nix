_: {
  config = {
    home-manager.users.jon = {
      programs.yazi = {
        enable = true;
        enableZshIntegration = true;
        settings = {
          log = {
            enabled = false;
          };
        };
      };
    };
  };
}

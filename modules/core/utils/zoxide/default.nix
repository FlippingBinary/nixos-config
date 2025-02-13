_: {
  config = {
    home-manager.users.jon = {
      programs.zoxide = {
        enable = true;
        enableZshIntegration = true;
      };
    };
  };
}

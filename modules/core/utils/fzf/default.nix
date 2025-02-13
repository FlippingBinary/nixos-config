_: {
  config = {
    home-manager.users.jon = {
      programs.fzf = {
        enable = true;
        enableZshIntegration = true;
      };
    };
  };
}

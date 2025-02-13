_: {
  config = {
    home-manager.users.jon = {
      programs.eza = {
        enable = true;
        enableZshIntegration = true;
        icons = "auto";
        git = true;
      };
    };
  };
}

{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./lazy_git.nix
    ./github.nix
  ];

  options.musselwhite-dev.development.git = {
    enable = lib.mkOption {
      default = true;
    };
    email = lib.mkOption {
      default = "35066367+FlippingBinary@users.noreply.github.com";
    };
  };

  config =
    let
      base = {
        programs.git = {
          enable = true;

          userEmail = config.musselwhite-dev.development.git.email;
          userName = "Jon Musselwhite";

          extraConfig = {
            init.defaultBranch = "main";
            push.autoSetupRemote = true;
            pull.rebase = true;

            user.signingkey = "/home/jon/.ssh/id_ed25519.pub";
            gpg.format = "ssh";

            github.user = "FlippingBinary";
            safe.directory = "/home/jon/projects/nixos-config";
          };
        };
      };
    in
    {
      home-manager.users.jon = { ... }: base;
      home-manager.users.root = { ... }: base;
    };
}

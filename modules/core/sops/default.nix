_: {
  sops = {
    defaultSopsFile = ../../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";

    age = {
      keyFile = "/home/jon/.config/sops/age/keys.txt";
      sshKeyPaths = [
        "/data/etc/ssh/ssh_host_ed25519_key"
      ];
      generateKey = true;
    };

    secrets = {
      "users/jon" = {
        neededForUsers = true;
      };

      "users/root" = {
        neededForUsers = true;
      };

      wireless = {};
    };
  };
}

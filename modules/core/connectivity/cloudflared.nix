{
  config,
  lib,
  ...
}:
{
  options.musselwhite-dev.core.cloudflared.enable = lib.mkEnableOption "cloudflared";

  config = lib.mkIf config.musselwhite-dev.core.cloudflared.enable {
    systemd.services."enable-cloudflare" = {
      description = "Enable Cloudflared Tunnel";
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        ExecStart = "/etc/profiles/per-user/jon/bin/cloudflared tunnel --config /home/jon/.cloudflared/config.yml run";
        Type = "simple";
      };
    };
  };
}

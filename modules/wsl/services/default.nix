{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.wsl-vpnkit
  ];
}

{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    musselwhite-dev.development.virtualisation = {
      hypervisor.enable = lib.mkEnableOption "Libvirt/KVM";
    };
  };

  config = lib.mkIf config.musselwhite-dev.development.virtualisation.hypervisor.enable {
    musselwhite-dev.core.zfs.systemCacheLinks = [ "/var/lib/libvirt" ];

    virtualisation.libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        swtpm.enable = true;
        verbatimConfig = ''
          nvram = [ "/run/libvirt/nix-ovmf/AAVMF_CODE.fd:/run/libvirt/nix-ovmf/AAVMF_VARS.fd", "/run/libvirt/nix-ovmf/OVMF_CODE.fd:/run/libvirt/nix-ovmf/OVMF_VARS.fd" ]
        '';
        runAsRoot = false;
      };

      onBoot = "start";
      onShutdown = "shutdown";
    };

    home-manager.users.jon = {
      home.packages = with pkgs; [
        virt-manager
      ];
    };

    users.users.jon = {
      extraGroups = [ "libvirtd" ];
    };
  };
}

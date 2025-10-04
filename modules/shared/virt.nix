{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.dots.shared.virt;
  user = config.dots.user;

in
{
  options.dots.shared.virt.enable = mkEnableOption "Enable virtualization stuff";
  config = mkIf cfg.enable {
    users.users.${user.username}.extraGroups = [
      "libvirtd"
      "kvm"
    ];
    environment.systemPackages = with pkgs; [
      virt-manager
      virt-viewer
      quickemu
      spice
      spice-gtk
      spice-protocol
      win-virtio
      win-spice
      qemu_full
    ];

    virtualisation = {
      libvirtd = {
        enable = true;

        qemu = {
          swtpm.enable = true;
          ovmf.enable = true;
          ovmf.packages = [ pkgs.OVMFFull.fd ];
        };
      };

      spiceUSBRedirection.enable = true;
    };

    services.spice-vdagentd.enable = true;
    networking.firewall.allowedTCPPorts = [
      22220
      5930
    ];
  };
}

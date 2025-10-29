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
  isPersistEnabled = config.dots.shared.persist.enable;
in
{
  options.dots.shared.virt.enable = mkEnableOption "Enable virtualization stuff";
  config = mkIf cfg.enable {
    dots.shared.persist.system = mkIf isPersistEnabled {
      directories = [
        "/var/lib/libvirt"
      ];
    };

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
          vhostUserPackages = with pkgs; [ virtiofsd ];
        };
      };

      spiceUSBRedirection.enable = true;
    };

    services.spice-vdagentd.enable = true;
    networking.firewall = {
      allowedTCPPorts = [
        22220
        5930
      ];
      extraCommands = ''
        # Port forwarding для SSH
        iptables -t nat -A PREROUTING -i enp0s25 -p tcp --dport 22220 -j DNAT --to-destination 192.168.122.144:22
        iptables -A FORWARD -d 192.168.122.144/32 -p tcp --dport 22 -j ACCEPT
      '';

      extraStopCommands = ''
        iptables -t nat -D PREROUTING -i enp0s25 -p tcp --dport 22220 -j DNAT --to-destination 192.168.122.144:22 2>/dev/null || true
        iptables -D FORWARD -d 192.168.122.144/32 -p tcp --dport 22 -j ACCEPT 2>/dev/null || true
      '';
    };
  };
}

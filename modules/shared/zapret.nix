{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.dots.shared.zapret;
in
{
  options.dots.shared.zapret.enable = mkEnableOption "Enable zapret dpi bypass";
  config = mkIf cfg.enable {
    services.zapret = {
      enable = true;
      configureFirewall = false;
      params = [
        "--dpi-desync=syndata,fake,split2"
        "--dpi-desync-fooling=md5sig"
        "--dpi-desync-any-protocol"
      ];
    };
    networking.firewall.extraCommands = ''
      iptables -t mangle -A POSTROUTING -p udp -m multiport --dports 50000:50099 -m mark ! --mark 0x40000000/0x40000000 -m connbytes --connbytes 1:1 --connbytes-mode packets --connbytes-dir original -j NFQUEUE --queue-num 200 --queue-bypass
      iptables -t mangle -I POSTROUTING -p tcp -m multiport --dports 80,443 -m connbytes --connbytes-dir=original --connbytes-mode=packets --connbytes 1:6 -m mark ! --mark 0x40000000/0x40000000 -j NFQUEUE --queue-num 200 --queue-bypass
    '';
  };
}

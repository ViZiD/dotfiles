{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.dots.shared.doh;
in
{
  options.dots.shared.doh.enable = mkEnableOption "Enable encrypted DNS config";
  config = mkIf cfg.enable {
    networking = {
      nameservers = [
        "127.0.0.1"
        "::1"
      ];
      dhcpcd = {
        enable = false;
        extraConfig = "nohook resolv.conf";
      };

      wireless.iwd.settings.Network.NameResolvingService = "none";
    };
    services.dnscrypt-proxy2 = {
      enable = true;
      # Settings reference:
      # https://github.com/DNSCrypt/dnscrypt-proxy/blob/master/dnscrypt-proxy/example-dnscrypt-proxy.toml
      settings = {
        listen_addresses = [
          "127.0.0.1:53"
          "[::1]:53"
        ];
        ipv6_servers = false;
        require_dnssec = true;
        cache = true;
        # Add this to test if dnscrypt-proxy is actually used to resolve DNS requests
        # query_log.file = "/var/log/dnscrypt-proxy/query.log";
        sources.public-resolvers = {
          urls = [
            "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
            "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
          ];
          cache_file = "/var/cache/dnscrypt-proxy/public-resolvers.md";
          minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
        };

        # You can choose a specific set of servers from https://github.com/DNSCrypt/dnscrypt-resolvers/blob/master/v3/public-resolvers.md
        server_names = [
          "serbica"
          "cs-nl"
          "comss.one"
          "doh-ibksturm"
          "ibksturm"
          "cloudflare"
          "cloudflare-security"
          "adguard-dns-doh"
          "mullvad-adblock-doh"
          "mullvad-doh"
          "nextdns"
          "quad9-dnscrypt-ip4-filter-pri"
          "google"
        ];
      };
    };
  };
}

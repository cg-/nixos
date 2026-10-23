{ config, lib, pkgs, ... }:

{
  sops.secrets = {
    resilio_global_key = {};
    resilio_phone_key = {};
    resilio_license = {
      path = "/var/lib/resilio-sync/license.btskey";
      owner = "rslsync";
      group = "rslsync";
      mode = "0400";
    };
  };

  networking.firewall.allowedTCPPorts = [ 4444 ];
  networking.firewall.allowedUDPPorts = [ 4444 ];

  sops.templates."rslsync.json" = {
    content = builtins.toJSON {
      device_name = config.networking.hostName;
      listening_port = 4444;
      storage_path = "/var/lib/resilio-sync/";
      use_gui = false;
      check_for_updates = false;
      download_limit = 0;
      upload_limit = 0;
      lan_encrypt_data = true;
      use_upnp = true;
      shared_folders = [
        {
          secret = config.sops.placeholder.resilio_global_key;
          dir = "/mnt/sync/global";
          known_hosts = [ 
            "100.68.117.10"  # metalbox
            "100.113.7.83"   # unraid
            "100.120.187.12" # iphone
          ];
          search_lan = true;
          use_dht = true;
          use_relay_server = true;
          use_sync_trash = true;
          use_tracker = true;
        }
        {
          secret = config.sops.placeholder.resilio_phone_key;
          dir = "/mnt/sync/phone";
          known_hosts = [ 
            "100.68.117.10"  # metalbox
            "100.113.7.83"   # unraid
            "100.120.187.12" # iphone
          ];
          search_lan = true;
          use_dht = true;
          use_relay_server = true;
          use_sync_trash = true;
          use_tracker = true;
        }
      ];
    };
    owner = "rslsync";
    group = "rslsync";
    mode = "0400";
  };

  services.resilio.enable = true;

  systemd.services.resilio.serviceConfig = {
    ExecStartPre = lib.mkForce "${pkgs.resilio-sync}/bin/rslsync --storage /var/lib/resilio-sync --license /var/lib/resilio-sync/license.btskey";
    ExecStart = lib.mkForce "${pkgs.resilio-sync}/bin/rslsync --nodaemon --config ${config.sops.templates."rslsync.json".path}";
  };

  systemd.tmpfiles.rules = [
    "d /mnt/sync/global 0770 rslsync rslsync -"
    "d /mnt/sync/phone 0770 rslsync rslsync -"
  ];
}

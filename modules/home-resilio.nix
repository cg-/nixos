{ config, lib, pkgs, ... }:

{
  sops.secrets = {
    resilio_global_key = {};
    resilio_phone_key = {};
  };
  networking.firewall.allowedTCPPorts = [ 4444 ];
  networking.firewall.allowedUDPPorts = [ 4444 ];

  services.resilio = {
    enable = true;
    enableWebUI = false;
    checkForUpdates = false;
    downloadLimit = 0;
    uploadLimit = 0;
    deviceName = config.networking.hostName;
    listeningPort = 4444;
  };

  services.resilio.sharedFolders = [
    {
      secret         = config.sops.placeholder.resilio_global_key;
      directory      = "/var/sync/global";
      knownHosts     = ["100.68.117.10"];
      useRelayServer = true;
      useTracker     = true;
      useDHT         = true;
      searchLAN      = true;
      useSyncTrash   = true;
    }
    {
      secret         = config.sops.placeholder.resilio_phone_key;
      directory      = "/var/sync/phone";
      knownHosts     = ["100.68.117.10"];
      useRelayServer = true;
      useTracker     = true;
      useDHT         = true;
      searchLAN      = true;
      useSyncTrash   = true;
    }
  ];

  systemd.tmpfiles.rules = [
    "d /var/sync/global 0770 rslsync rslsync -"
    "d /var/sync/phone 0770 rslsync rslsync -"
  ];
}

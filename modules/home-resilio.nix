{ config, lib, pkgs, ... }:

{
  sops.secrets = {
    resilio_username = {};
    resilio_password = {};
    resilio_license = {
      path = "/mnt/sync/license.btskey";
      owner = "rslsync";
      group = "rslsync";
      mode = "0400";
    };
  };

  services.resilio = {
    enable = true;
    httpLogin = config.sops.placeholder.resilio_username;
    httpLogin = config.sops.placeholder.resilio_password;
    deviceName = config.networking.hostName;
    directoryRoot = "/mnt/sync";
    enableWebUI = true;
    httpListenAddr = "127.0.0.1";
    httpListenPort = 8888;
    storagePath = "/var/lib/resilio-sync";
    useUpnp = true;
  };

  systemd.tmpfiles.rules = [
    "d /mnt/sync/global 0770 rslsync rslsync -"
    "d /mnt/sync/phone 0770 rslsync rslsync -"
    "d /mnt/sync/metal 0770 rslsync rslsync -"
  ];
}

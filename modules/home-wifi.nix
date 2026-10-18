{ config, lib, pkgs, ... }:

{
  networking.networkmanager.enable = true;

  sops.secrets."wifi_password" = {};

  sops.templates."wifi-jnc.nmconnection" = {
    content = ''
      [connection]
      id=J&C
      type=wifi
      autoconnect=true

      [wifi]
      mode=infrastructure
      ssid=J&C

      [wifi-security]
      key-mgmt=sae
      pmf=3
      psk=${config.sops.placeholder.wifi_password}

      [ipv4]
      method=auto

      [ipv6]
      method=auto
    '';
    path = "/etc/NetworkManager/system-connections/J&C.nmconnection";
    owner = "root";
    group = "root";
    mode = "0600";
  };
}

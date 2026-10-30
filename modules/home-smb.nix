{ config, pkgs, lib, ... }:

let
  tailscale_shares = [
    { name = "backups"; path = "//100.113.7.83/Backups"; }
    { name = "documents"; path = "//100.113.7.83/Documents"; }
    { name = "downloads"; path = "//100.113.7.83/Downloads"; }
    { name = "isos"; path = "//100.113.7.83/isos"; }
    { name = "media"; path = "//100.113.7.83/Media"; }
  ];

  local_shares = [
    { name = "backups"; path = "//192.168.10.50/Backups"; }
    { name = "documents"; path = "//192.168.10.50/Documents"; }
    { name = "downloads"; path = "//192.168.10.50/Downloads"; }
    { name = "isos"; path = "//192.168.10.50/isos"; }
    { name = "media"; path = "//192.168.10.50/Media"; }
  ];

  automountOpts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60min,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
  commonOptions = [
    "${automountOpts}"
    "_netdev"
    "uid=1000"
    "gid=100"
    "file_mode=0660"
    "dir_mode=0770"
    "vers=3.1.1"
  ];

in {
  environment.systemPackages = [ pkgs.cifs-utils ];
  boot.kernelModules = [ "cifs" ];
  boot.supportedFilesystems = [ "cifs" ];

  sops.secrets.smb_password = {};
  sops.secrets.smb_username = {};

  sops.templates."smb-credentials" = {
    content = ''
      username=${config.sops.placeholder.smb_username}
      password=${config.sops.placeholder.smb_password}
    '';
    owner = "root";
    group = "root";
    mode = "0400";
  };

  fileSystems = lib.listToAttrs (
    (map (share: {
      name = "/mnt/tailscale/${share.name}";
      value = {
        device = share.path;
        fsType = "cifs";
        options = commonOptions ++ [
          "credentials=${config.sops.templates."smb-credentials".path}"
        ];
      };
    }) tailscale_shares)
    ++
    (map (share: {
      name = "/mnt/local/${share.name}";
      value = {
        device = share.path;
        fsType = "cifs";
        options = commonOptions ++ [
          "credentials=${config.sops.templates."smb-credentials".path}"
        ];
      };
    }) local_shares)
  );
}

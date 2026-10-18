{ config, lib, pkgs, ... }:

{
  sops = {
    defaultSopsFile = ../secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/var/lib/sops-nix/keys.txt";

    secrets."ssh_rsa_private_key" = {
      path = "/home/cg/.ssh/id_rsa";
      owner = "cg";
      group = "users";
      mode = "0600";
    };
  };

  system.activationScripts.ensure-ssh-dir = ''
    mkdir -p /home/cg/.ssh
    chmod 700 /home/cg/.ssh
    chown cg:users /home/cg/.ssh
  '';
}

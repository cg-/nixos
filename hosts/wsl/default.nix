{ config, pkgs, ... }: {
  imports = [ 
      ../../modules/ssh-secret.nix 
      ../../modules/user-cg.nix 
    ];

  sops = {
    defaultSopsFile = ../../secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/var/lib/sops-nix/keys.txt";
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  wsl.enable = true;
  wsl.defaultUser = "cg";
  networking.hostName = "wsl";

  system.stateVersion = "26.05";
}

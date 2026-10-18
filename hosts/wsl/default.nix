{ config, pkgs, ... }: {
  imports = [ 
      ../../modules/ssh-secret.nix 
    ];

  sops = {
    defaultSopsFile = ../../secrets.yaml;
    age.keyFile = "/var/lib/sops-nix/keys.txt";
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  wsl.enable = true;
  wsl.defaultUser = "cg";
  networking.hostName = "wsl";

  users.users.cg = {
    isNormalUser = true;
    description = "Cole Grim";
    extraGroups = [ "wheel" "networkmanager" ];
  };

  system.stateVersion = "26.05";
}

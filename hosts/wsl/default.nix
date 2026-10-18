{ config, pkgs, ... }: {
  imports = [ 
      ../../modules/ssh-secret.nix 
    ];

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

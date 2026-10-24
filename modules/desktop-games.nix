{ pkgs, lib, inputs, ... }:

{
  nix.settings = {
    substituters = [ "https://nix.unom.io" ];
    trusted-public-keys = [ "punktfunk-cache-1:yhOJmHxzg6tzXpxSFzlYn6Pc6r0jHprsWqt8MZC654o=" ];
  };

  services.flatpak = {
    enable = true;

    remotes = [
      {
        name = "flathub";
        location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
      }
      {
        name = "GeForceNOW";
        location = "https://international.download.nvidia.com/GFNLinux/flatpak/geforcenow.flatpakrepo";
      }
    ];

    packages = [
      { appId = "com.nvidia.geforcenow"; origin = "GeForceNOW"; }
    ];
  };

  services.punktfunk.host = {
    enable = true;
    users = [ "cg" ];
    openFirewall = true;
    desktopSession = true;
  };
  services.punktfunk.seats.enable = true;

  hardware.steam-hardware.enable = true;
  hardware.xpad-noone.enable = lib.mkForce false;

  environment.systemPackages = (with pkgs; [
    faugus-launcher
    discord
    gamescope
    gamemode
    mangohud
    xivlauncher-rb
    gamepad-tool
    wowup-cf
  ]) ++ [
    inputs.punktfunk.packages.${pkgs.system}.punktfunk-client
  ];
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    gamescopeSession.enable = true;
  };
  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };
}

{ pkgs, lib, ... }:

{
  nix.settings = {
    substituters = [ "https://nix.unom.io" ];
    trusted-public-keys = [ "punktfunk-cache-1:yhOJmHxzg6tzXpxSFzlYn6Pc6r0jHprsWqt8MZC654o=" ];
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

  environment.systemPackages = with pkgs; [
    faugus-launcher
    discord
    gamescope
    gamemode
    mangohud
    xivlauncher-rb
    gamepad-tool
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

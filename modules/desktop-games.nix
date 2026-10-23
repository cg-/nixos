{ pkgs, lib, ... }:

{
  hardware.xone.enable = true;
  hardware.xpad-noone.enable = lib.mkForce false;

  environment.systemPackages = with pkgs; [
    faugus-launcher
    gamescope
    gamemode
    mangohud
    xivlauncher
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

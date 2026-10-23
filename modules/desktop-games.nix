{ pkgs, lib, ... }:

{
  hardware.steam-hardware.enable = true;
  hardware.xpad-noone.enable = lib.mkForce false;

  environment.systemPackages = with pkgs; [
    faugus-launcher
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

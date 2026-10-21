{ pkgs, ... }:

{
  hardware.xone.enable = true;

  environment.systemPackages = with pkgs; [
    faugus-launcher
    xivlauncher
    gamescope
    gamemode
    mangohud
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

{ pkgs, ... }:

{
  hardware.xone.enable = true;

  environment.systemPackages = with pkgs; [
    faugus-launcher
    gamescope
    gamemode
    mangohud
    (xivlauncher-rb.override { useGameMode = true; })
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

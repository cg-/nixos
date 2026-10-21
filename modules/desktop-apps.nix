{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    firefox
    microsoft-edge
  ];
}

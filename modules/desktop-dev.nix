{ pkgs, config, ... }:

{
  environment.systemPackages = with pkgs; [
    zed-editor
    lmstudio
    nixd
    nil
  ];
}

{ config, pkgs, ... }:

{
  services.tailscale = {
    enable = true;
    authKeyFile = config.sops.secrets.tailscale_auth_key.path;
    extraUpFlags = [ "--accept-routes" ];
  };

  sops.secrets.tailscale_auth_key = {
    mode = "0400";
  };
  
  # Ensure tailscale packages are available in your system path
  environment.systemPackages = with pkgs; [
    tailscale
  ];
}

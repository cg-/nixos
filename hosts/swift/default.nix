{ config, lib, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/ssh-secret.nix
    ../../modules/tailscale.nix
    ../../modules/home-wifi.nix
    ../../modules/home-smb.nix
    ../../modules/home-resilio.nix
    ../../modules/desktop-plasma.nix
    ../../modules/desktop-apps.nix
    ../../modules/desktop-games.nix
    ../../modules/user-cg.nix
  ];
  nixpkgs.config.allowUnfree = true;

  # Global sops-nix configuration for this host
  sops = {
    defaultSopsFile = ../../secrets.yaml;
    age.keyFile = "/var/lib/sops-nix/keys.txt";
  };

  # ZFS and Bootloader Settings
  networking.hostId = "84251a3f";
  networking.firewall.enable = true;
  services.zfs.autoScrub.enable = true;
  services.zfs.trim.enable = true;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.kernelParams = [
    "i915.force_probe=!*"
    "xe.force_probe=*"
    "consoleblank=0"
  ];

  networking.hostName = "swift";
  time.timeZone = "US/Central";

  # Graphics & Intel Drivers
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
    ];
  };
  services.hardware.bolt.enable = true;
  services.xserver.videoDrivers = ["amdgpu" ];

  # System Packages for the Laptop environment
  environment.systemPackages = with pkgs; [
    git
    wget
    curl
  ];

  # OpenSSH Daemon
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = true;
    };
  };

  system.stateVersion = "26.05";
}

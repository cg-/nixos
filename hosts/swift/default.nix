{ config, lib, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/ssh-secret.nix
    ../../modules/tailscale.nix
    ../../modules/home-wifi.nix
    ../../modules/home-smb.nix
    ../../modules/home-resilio.nix
    ../../modules/desktop-plasma.nix
    ../../modules/desktop-games.nix
    ../../modules/desktop-dev.nix
    ../../modules/desktop-apps.nix
    ../../modules/desktop-virt.nix
    ../../modules/user-cg.nix
    ../../modules/garbage-collection.nix
  ];
  nixpkgs.config.allowUnfree = true;

  # Global sops-nix configuration for this host
  sops = {
    defaultSopsFile = ../../secrets.yaml;
    age.keyFile = "/var/lib/sops-nix/keys.txt";
  };

  # swapfile
  swapDevices = [{
    device = "/dev/zvol/zroot/swap";
  }];

  # ZFS and Bootloader Settings
  boot.zfs.forceImportRoot = false;
  networking.hostId = "84251a3f";
  networking.firewall.enable = true;
  services.zfs.autoScrub.enable = true;
  services.zfs.trim.enable = true;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams = [
    "i915.force_probe=!*"
    "xe.force_probe=*"
    "zfs.zfs_arc_max=2147483648"
  ];
  boot.kernelModules = [ "acer-wmi" ];
  services.tlp = {
    enable = true;
    settings = {
      START_CHARGE_THRESH_BAT0 = 75;
      STOP_CHARGE_THRESH_BAT0 = 80;
      PLATFORM_PROFILE_ON_AC = "performance";
      PLATFORM_PROFILE_ON_BATTERY = "low-power";
    };
  };
  services.power-profiles-daemon.enable = false;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  networking.hostName = "swift";
  time.timeZone = "US/Central";

  # Graphics & Intel Drivers
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
      vpl-gpu-rt
      vulkan-loader
      vulkan-validation-layers
      vulkan-extension-layer
    ];
  };
  services.hardware.bolt.enable = true;

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

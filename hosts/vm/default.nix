{ config, lib, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/ssh-secret.nix
    ../../modules/tailscale.nix
    ../../modules/desktop-niri.nix
    ../../modules/user-cg.nix
  ];

  sops = {
    defaultSopsFile = ../../secrets.yaml;
    age.keyFile = "/var/lib/sops-nix/keys.txt";
  };

  virtualisation.hypervGuest.enable = true;

  boot.initrd.kernelModules = [
    "hv_vmbus"
    "hv_storvsc"
    "hv_netvsc"
  ];

  networking.networkmanager.enable = true;

  # ZFS and Bootloader Settings
  networking.hostId = "84251a3c";
  services.zfs.autoScrub.enable = true;
  services.zfs.trim.enable = true;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams = [
    "consoleblank=0"
  ];

  networking.hostName = "vm";
  time.timeZone = "US/Central";

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd niri-session";
        user = "greeter";
      };
    };
  };

  # Graphics & Intel Drivers
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

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

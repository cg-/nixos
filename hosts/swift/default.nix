{ config, lib, pkgs, ... }: {
  imports = [ 
      ./hardware-configuration.nix 
      ../../modules/ssh-secret.nix
      ../../modules/tailscale.nix
    ];

  sops.defaultSopsFile = ../../secrets.yaml;
  sops.age.keyFile = "/var/lib/sops-nix/key.txt";
  sops.secrets."wifi_password" = {
    owner = "root";
    group = "root";
    mode = "0400";
  };

  # ZFS and Bootloader Settings
  networking.hostId = "84251a3f";
  services.zfs.autoScrub.enable = true;
  services.zfs.trim.enable = true;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams = [
    "i915.force_probe=!*"
    "xe.force_probe=*"
    "consoleblank=0"
  ];

  networking.hostName = "swift";

  # Network & WiFi
  networking.networkmanager.enable = true;
  networking.networkmanager.ensureProfiles.profiles = {
    "J&C" = {
      connection = {
        id = "J&C";
        type = "wifi";
      };
      wifi = {
        mode = "infrastructure";
        ssid = "J&C";
      };
      wifi-security = {
        key-mgmt = "sae";
        pmf = 3;
	psk = "@wifi_password@";
      };
    };
  };

  time.timeZone = "US/Central";

  # Audio & Display Manager (Greetd + Niri)
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        # Changed from pkgs.greetd.tuigreet to pkgs.tuigreet
        command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd niri-session";
        user = "greeter";
      };
    };
  };

  # Graphics & Intel Drivers
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
    ];
  };

  # System User
  users.users.cg = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };

  # System Packages for the Laptop environment
  environment.systemPackages = with pkgs; [
    git
    wget
    curl
    niri
    alacritty
    fuzzel
    xwayland-satellite
    waybar
    firefox
    vim
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

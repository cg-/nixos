{ config, pkgs, ... }: {
  sops.secrets.user_password_hash = {
    neededForUsers = true; 
  };
  users.users.cg = {
    isNormalUser = true;
    hashedPasswordFile = config.sops.secrets.user_password_hash.path;
    extraGroups = [ "wheel" "networkmanager" "rslsync" ];
    openssh.authorizedKeys.keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDprDzuHDahuGo4wIjYmp4fVwMpaksHeAquEHg+AaLTy+BzdWCsGTHd3dyFaACSektaCvpQLLawDjeqURQzx0CZC3FR5dYf2BVuOY5S/buHrL6bMt0LnyA7tb9Ahfn8SA8EtWURihyIaBehLmNIJBpgzWRxRxp6GG8B//OM1GDTaJda47Wvu8WRtRMClfEGtm+iu5fSweZhhGhvk+TCNrT73awBjB61v7J514/XQX5SGo+IodGscpkX0pu1eQF7tbJFvW3ONOEPzd0PcK1jl3XOfaneFzVvfee180N1Br/rC6CqzqoVdGC9qUy9Bhxwl+4wrR3V9YPaHQ6jtNFnjwEv"
    ];
  };
}

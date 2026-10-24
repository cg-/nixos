{ config, pkgs, inputs, lib, ... }: {
  imports = [ ];

  home.username = "cg";
  home.homeDirectory = if pkgs.stdenv.hostPlatform.isDarwin then "/Users/cg" else "/home/cg";
  home.stateVersion = "26.05";

  home.file.".nixos" = {
    source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos";
  };

  home.activation.createWorkspace = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    run mkdir -p ~/workspace
  '';

  programs.home-manager.enable = true;

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings = {
      "*" = {
        identityFile = "~/.ssh/id_rsa";
        addKeysToAgent = "yes";
      };
    };
  };

  services.ssh-agent.enable = true;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    extraConfig = ''
      set number
      set relativenumber
      set expandtab
      set shiftwidth=2
      set mouse=
    '';
  };

  programs.git = {
    enable = true;
    
    # Use the new settings structure
    settings = {
      user = {
        name = "Cole Grim";
        email = "cg@netfla.me";
      };
      init = {
        defaultBranch = "main";
      };
      pull = {
        rebase = true;
      };
    };
  };

  programs.bash = {
    enable = true;
    initExtra = ''
      # Kali Linux style prompt (red user@host, blue path)
      PS1='\[\033[01;31m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

      fastdl() {
      if [ -z "$1" ]; then
        echo "Usage: fastdl <URL>"
        return 1
      fi
      aria2c \
        --max-connection-per-server=16 \
        --split=16 \
        --min-split-size=1M \
        --continue=true \
        "$@"
      }

      nixsh() {
      if [ -z "$1" ]; then
        echo "Error: Please specify a package name."
        return 1
      fi
      nix shell nixpkgs#"$1" --extra-experimental-features "flakes nix-command"
      }
    '';
  };

  home.packages = with pkgs; [
    git
    curl
    wget
    vim
    age
    sops
    aria2
    cacert
  ];
}

{ config, pkgs, inputs, lib, ... }: {
  imports = [ ];
  nixpkgs.config.allowUnfree = true;

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

  programs.zed-editor = {
    enable = true;
    extensions = [ "nix" "toml" "rust" ];
    userSettings = {
      vim_mode = true;
      theme = {
        mode = "system";
        dark = "One Dark";
        light = "One Light";
      };
      hour_format = "hour24";
      language_models = {
        openai = {
          "LM Studio" = {
            api_url = "http://localhost:1234/v1";
            available_models = [
              {
                model = "qwen2.5-7b-instruct";
                display_name = "Qwen Instruct";
                max_tokens = 8192;
                supports_tools = true;
              }
            ];
          };
        };
      };
      agent = {
        default_model = {
          provider = "openai";
          model = "qwen2.5-7b-instruct";llama-3-8b-instruct";
        };
        tools = {
          terminal = true;
        };
      };
    };
  };

  programs.starship = {
    enable = true;
    enableBashIntegration = true;
  };

  programs.bash = {
    enable = true;
    initExtra = ''
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
    just
  ];
}

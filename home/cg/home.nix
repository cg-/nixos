{ pkgs, ... }: {
  home.username = "cg";
  home.homeDirectory = if pkgs.stdenv.isDarwin then "/Users/cg" else "/home/cg";
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;

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
    '';
  };

  home.packages = with pkgs; [
    git
    curl
    wget
    vim
    age
    sops
  ];
}

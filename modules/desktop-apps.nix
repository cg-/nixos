{ pkgs, ... }:

{
  imports = [
    ./dod-stuff.nix
  ];

  environment.systemPackages = with pkgs; [
    microsoft-edge
    fastmail-desktop
    localsend
    slack
    spotify
    freerdp
    remmina
    obsidian
    onlyoffice-desktopeditors
  ];

  # needed for onlyoffice fonts
  system.userActivationScripts = {
    copy-fonts-local-share = {
      text = ''
        rm -rf ~/.local/share/fonts
        mkdir -p ~/.local/share/fonts
        cp ${pkgs.corefonts}/share/fonts/truetype/* ~/.local/share/fonts/
        chmod 544 ~/.local/share/fonts
        chmod 444 ~/.local/share/fonts/*
      '';
    };
  };

  environment.etc."opt/edge/policies/managed/default_search_engine.json".text = builtins.toJSON {
    DefaultSearchProviderEnabled = true;
    DefaultSearchProviderName = "Google";
    DefaultSearchProviderKeyword = "google.com";
    DefaultSearchProviderSearchURL = "https://google.com/search?q={searchTerms}";
    DefaultSearchProviderSuggestURL = "https://google.com/complete/search?output=chrome&q={searchTerms}";
  };
}

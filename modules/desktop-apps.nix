{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    microsoft-edge
    fastmail-desktop
    localsend
  ];

  environment.etc."opt/edge/policies/managed/default_search_engine.json".text = builtins.toJSON {
    DefaultSearchProviderEnabled = true;
    DefaultSearchProviderName = "Google";
    DefaultSearchProviderKeyword = "google.com";
    DefaultSearchProviderSearchURL = "https://google.com/search?q={searchTerms}";
    DefaultSearchProviderSuggestURL = "https://google.com/complete/search?output=chrome&q={searchTerms}";
  };
}

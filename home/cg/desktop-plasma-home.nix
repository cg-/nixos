{ inputs, pkgs, ... }: {
  imports = [
    ./home.nix
    inputs.plasma-manager.homeManagerModules.plasma-manager
  ];

  programs.plasma.enable = true;

  programs.plasma = {
    workspace = {
      theme = "breeze-dark";
      colorScheme = "BreezeDark";
      wallpaper = ../../assets/wallpaper.png;
    };

    panels = [
      {
        location = "bottom";
        alignment = "center";
        # Setting floating to false removes the margin/gap around the panel
        floating = false;
        lengthMode = "fill"; # Or "maximum" depending on your preference
        height = 44;
        
        widgets = [
          "org.kde.plasma.kickoff" # Application Launcher
          "org.kde.plasma.icontasks" # Task Manager
          "org.kde.plasma.systemtray"
          "org.kde.plasma.digitalclock"
        ];
      }
    ];
  };
}

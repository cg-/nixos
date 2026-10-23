{ inputs, pkgs, ... }: {
  imports = [
    ./home.nix
    inputs.plasma-manager.homeManagerModules.plasma-manager
  ];


  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "microsoft-edge.desktop";
      "x-scheme-handler/http" = "microsoft-edge.desktop";
      "x-scheme-handler/https" = "microsoft-edge.desktop";
      "x-scheme-handler/about" = "microsoft-edge.desktop";
      "x-scheme-handler/unknown" = "microsoft-edge.desktop";
    };
  };

  programs.plasma = {
    enable = true;
    workspace = {
      theme = "breeze-dark";
      colorScheme = "BreezeDark";
      wallpaper = ../../assets/wallpaper.png;
    };

    configFile = {
      "kdeglobals"."General"."TerminalApplication" = "alacritty";
      "kdeglobals"."General"."TerminalService" = "alacritty.desktop";
      "kdeglobals"."General"."BrowserApplication" = "microsoft-edge.desktop";
    };

    panels = [
      {
        location = "bottom";
        alignment = "center";
        # Setting floating to false removes the margin/gap around the panel
        floating = false;
        lengthMode = "fill"; # Or "maximum" depending on your preference
        screen = 0;
        height = 44;
        
        widgets = [
          "org.kde.plasma.kickoff" # Application Launcher
          "org.kde.plasma.icontasks" # Task Manager
          "org.kde.plasma.systemtray"
          "org.kde.plasma.digitalclock"
        ];
      }
    ];

    shortcuts = {
      "services/org.kde.konsole.desktop"."_launch" = "none";
    };

    hotkeys.commands."launch-alacritty" = {
      name = "Launch Alacritty";
      key = "Ctrl+Alt+T";
      command = "alacritty";
    };
  };
}

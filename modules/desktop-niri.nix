{ config, pkgs, ... }:

{
  programs.niri.enable = true;

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    font-awesome
    noto-fonts
    noto-fonts-color-emoji
  ];

  environment.systemPackages = with pkgs; [
    firefox
    waybar
    fuzzel
    mako
    swww
    swaylock-effects
    wl-clipboard
    libnotify
    alacritty
    fastfetch
    adwaita-icon-theme
  ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    GTK_THEME = "Adwaita:dark";
    COLORTERM = "truecolor";
  };

  environment.etc."alacritty/alacritty.toml".text = ''
    [window]
    opacity = 0.88
    padding = { x = 12, y = 12 }
    decorations = "none"

    [font]
    normal = { family = "JetBrainsMono Nerd Font", style = "Regular" }
    size = 11.0

    [colors.primary]
    background = "#0a0b10"
    foreground = "#00f0ff"

    [colors.normal]
    black   = "#1a1c23"
    red     = "#ff0055"
    green   = "#00ff66"
    yellow  = "#f3e430"
    blue    = "#00f0ff"
    magenta = "#9d00ff"
    cyan    = "#00f0ff"
    white   = "#c0c5ce"

    [colors.bright]
    black   = "#2e3240"
    red     = "#ff3377"
    green   = "#33ff88"
    yellow  = "#f5ea5c"
    blue    = "#33f3ff"
    magenta = "#b133ff"
    cyan    = "#33f3ff"
    white   = "#ffffff"
  '';

  environment.etc."fuzzel/fuzzel.ini".text = ''
    [main]
    font=JetBrainsMono Nerd Font:size=12
    prompt="⚡ "
    icon-theme=Adwaita
    width=40
    horizontal-pad=20
    vertical-pad=15
    inner-pad=10
    line-height=20

    [colors]
    background=0a0b10f0
    text=00f0ffff
    match=ff0055ff
    selection=1a1c23ff
    selection-text=ff0055ff
    selection-match=00f0ffff
    border=ff0055ff

    [border]
    width=2
    radius=8
  '';

  environment.etc."xdg/waybar/config".text = builtins.toJSON {
    layer = "top";
    position = "top";
    height = 36;
    spacing = 4;
    modules-left = [ "niri/workspaces" "niri/window" ];
    modules-center = [ "clock" ];
    modules-right = [ "pulseaudio" "network" "battery" "tray" ];

    clock = {
      format = "<span>󰥔 </span>{:%H:%M | %a %b %d}";
      tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
    };
    battery = {
      format = "<span>󰁹 </span>{capacity}%";
    };
    network = {
      format-wifi = "<span>󰤨 </span>{essid}";
      format-disconnected = "<span>󰤭 </span>Disconnected";
    };
    pulseaudio = {
      format = "<span>󰕾 </span>{volume}%";
    };
  };

  environment.etc."xdg/waybar/style.css".text = ''
    * {
        font-family: "JetBrainsMono Nerd Font", monospace;
        font-size: 13px;
        font-weight: bold;
    }

    window#waybar {
        background-color: rgba(10, 11, 16, 0.85);
        border-bottom: 2px solid #ff0055;
        color: #00f0ff;
    }

    #workspaces button {
        padding: 0 8px;
        color: #707880;
        border-bottom: 2px solid transparent;
    }

    #workspaces button.active {
        color: #ff0055;
        border-bottom: 2px solid #00f0ff;
    }

    #clock, #battery, #network, #pulseaudio, #tray {
        padding: 0 12px;
        margin: 4px 2px;
        background: #14161f;
        border: 1px solid #333842;
        border-radius: 6px;
        color: #00f0ff;
    }

    #clock span, #battery span, #network span, #pulseaudio span {
        color: #ff0055;
    }
  '';

  environment.etc."mako/config".text = ''
    background-color=#0a0b10f0
    text-color=#00f0ff
    border-color=#ff0055
    border-size=2
    border-radius=8
    default-timeout=5000
    font=JetBrainsMono Nerd Font 10
  '';
}

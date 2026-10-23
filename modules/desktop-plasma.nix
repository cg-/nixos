{ pkgs, ... }:

{
  services.xserver.enable = true;

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  services.desktopManager.plasma6.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  environment.systemPackages = with pkgs; [
    kdePackages.ark
    kdePackages.filelight
    kdePackages.kcalc
    kdePackages.konsole
    kdePackages.okular
    kdePackages.gwenview
    kdePackages.kate
    wl-clipboard
  ];

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    elisa
    kmail
    kdepim-addons
    kdepim-runtime
  ];
}

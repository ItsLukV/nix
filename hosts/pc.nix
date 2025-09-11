{
  config,
  pkgs,
  inputs,
  ...
}: {
  networking.hostName = "pc";
  system.stateVersion = "25.05";
  imports = [
    ./hardware/hardware-pc.nix
    ./shared.nix
  ];
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages."${pkgs.system}".hyprland;
    xwayland.enable = true;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    settings.monitor = [
      "HDMI-A-1,preferred,auto,1"
      "DP-1,preferred,auto-left,1"
      "DP-2,preferred,auto-right,1"
    ];
  };

  services.displayManager = {
    sddm = {
      enable = true;
      wayland.enable = true; # Required for Wayland sessions
    };
    defaultSession = "hyprland";
  };

  swapDevices = [{
    device = "/swapfile";
    size = 16 * 1024; # 16GB
  }];

  services.displayManager.gdm.enable = false;
  services.desktopManager.gnome.enable = false;
  environment.variables = {
    USE_WAYLAND_GRIM = 1;
  };
}

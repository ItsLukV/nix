{
  config,
  pkgs,
  inputs,
  ...
}: {
  networking.hostName = "pc";
  system.stateVersion = "25.05";
  imports = [
    ./hardware-pc.nix
    ../shared.nix
    ./libreoffice.nix
    ./steam.nix
  ];
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages."${pkgs.stdenv.hostPlatform.system}".hyprland;
    xwayland.enable = true;
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

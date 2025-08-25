{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  networking.hostName = "laptop";
  system.stateVersion = "25.05";
  imports = [
    ./hardware-configuration.nix
  ];

  programs.hyprland = {
    enable = lib.mkDefault true;
    package = inputs.hyprland.packages."${pkgs.system}".hyprland;
    xwayland.enable = true;
  };
  
  services.displayManager.sddm = {
    enable = lib.mkDefault true;
    wayland.enable = true;
  };
  services.displayManager.defaultSession = "hyprland";

  services.xserver = {
    enable = true;
    displayManager = {
      sessionPackages = [ inputs.hyprland.packages."${pkgs.system}".hyprland ];
    };
  };

  environment.variables = {
    USE_WAYLAND_GRIM = 1;
  };

  # GNOME as a specialization only
  specialisation = {
    gnome = {
      inheritParentConfig = true;
      configuration = {
        services.displayManager.gdm.enable = true;
        services.desktopManager.gnome.enable = true;
        services.gnome.core-apps.enable = false;
        services.gnome.core-developer-tools.enable = false;
        services.gnome.games.enable = false;
        environment.systemPackages = with pkgs; [ gnome-console ];
        environment.gnome.excludePackages = with pkgs; [ gnome-tour gnome-user-docs ];

        # Disable Hyprland
        programs.hyprland.enable = lib.mkForce false;
        services.displayManager.sddm.enable = lib.mkForce false;
      };
    };
  };
}
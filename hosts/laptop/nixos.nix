{
  config,
  pkgs,
  inputs,
  ...
}: {
  networking.hostName = "laptop";
  system.stateVersion = "25.05";

  # iwlwifi mishandles channel-switch/roaming on the home mesh AP, causing
  # repeated disconnects. iwd's roaming/CSA handling copes with this better
  # than wpa_supplicant (the NetworkManager default).
  networking.wireless.iwd.enable = true;
  networking.networkmanager.wifi.backend = "iwd";

  # TEMPORARY: verbose iwd logging to capture the reason for the next
  # WiFi3673gms drop. Revert once we've caught it in `journalctl -u iwd`.
  systemd.services.iwd.serviceConfig.ExecStart = [
    ""
    "${config.networking.wireless.iwd.package}/libexec/iwd -d"
  ];

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
  imports = [
    ./hardware-laptop.nix
    ../shared.nix
  ];
  # programs.hyprland = {
  #   enable = true;
  #   package = inputs.hyprland.packages."${pkgs.stdenv.hostPlatform.system}".hyprland;
  #   xwayland.enable = true;
  # };

  hardware.nvidia = {
    modesetting.enable = true;
    open = false;

    prime = {
      sync.enable = true;
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:60:0:0";
    };
  };

  services.displayManager.sddm.wayland.enable = true;
  /*
  services.displayManager = {
    sddm = {
      enable = true;
      wayland.enable = true; # Required for Wayland sessions
    };
    defaultSession = "hyprland";
  };
  */
  swapDevices = [{
    device = "/swapfile";
    size = 16 * 1024; # 16GB
  }];

  services.logind = {
    lidSwitch = "suspend";
    lidSwitchExternalPower = "suspend";
  };

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  environment.variables = {
    USE_WAYLAND_GRIM = 1;
    WLR_NO_HARDWARE_CURSORS = "1"; 
    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  };
}

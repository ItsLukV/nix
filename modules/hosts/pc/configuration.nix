{ self, inputs, ... }: {

  flake.nixosModules.pcConfiguration = {config, pkgs, inputs, ... }: {
    # import any other modules from here
    imports = [
      self.nixosModules.pcHardware
      self.nixosModules.git
      self.nixosModules.niri
    ];


    networking.hostName = "pc";
    programs.hyprland = {
      enable = true;
      # package = inputs.hyprland.packages."${pkgs.stdenv.hostPlatform.system}".hyprland;
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


    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    # Nix flakes
    nix.settings.experimental-features = ["nix-command" "flakes"];

    # Fonts
    fonts.packages = with pkgs; [
      nerd-fonts.fira-code
      nerd-fonts.jetbrains-mono
    ];

    # Automatic cleanup
    nix.gc.automatic = true;
    nix.gc.dates = "weekly";
    nix.gc.options = "--delete-older-than 10d";
    nix.settings.auto-optimise-store = true;

    services.xserver.enable = true;
    services.displayManager = {
      sddm = {
        enable = true;
        wayland.enable = false;
        autoNumlock = true;
      };
      defaultSession = "hyprland";
    };

    # Nvidia driver
    hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
    hardware.nvidia.open = false;
    services.xserver.videoDrivers = ["nvidia"];

    # Enable networking
    networking.networkmanager.enable = true;

    # Set your time zone.
    time.timeZone = "Europe/Copenhagen";

    # Set time for windows and linux to agree
    time.hardwareClockInLocalTime = true;

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = {
      LC_ADDRESS = "da_DK.UTF-8";
      LC_IDENTIFICATION = "da_DK.UTF-8";
      LC_MEASUREMENT = "da_DK.UTF-8";
      LC_MONETARY = "da_DK.UTF-8";
      LC_NAME = "da_DK.UTF-8";
      LC_NUMERIC = "da_DK.UTF-8";
      LC_PAPER = "da_DK.UTF-8";
      LC_TELEPHONE = "da_DK.UTF-8";
      LC_TIME = "da_DK.UTF-8";
    };

    # Configure console keymap
    console.keyMap = "dk";

    # Enable CUPS to print documents.
    services.printing.enable = true;
    # Enable sound with pipewire.
  services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      
      # Ensure the plugin package is available to PipeWire
      extraLv2Packages = [ pkgs.rnnoise-plugin ];

      extraConfig.pipewire."99-input-denoising" = {
        "context.modules" = [
          {
            name = "libpipewire-module-filter-chain";
            args = {
              "node.description" = "Noise Canceling Source";
              "media.name" = "Noise Canceling Source";
              "filter.graph" = {
                nodes = [
                  {
                    type = "ladspa";
                    name = "rnnoise";
                    plugin = "${pkgs.rnnoise-plugin}/lib/ladspa/librnnoise_ladspa.so";
                    label = "noise_suppressor_mono";
                    control = { "VAD Threshold (%)" = 50.0; };
                  }
                ];
              };
              "capture.props" = {
              "node.name" = "capture.rnnoise_source";
              "node.passive" = true;
              "audio.rate" = 48000;
              "target.object" = "alsa_input.pci-0000_0c_00.6.analog-stereo";
              };
              "playback.props" = {
                "node.name" = "rnnoise_source";
                "media.class" = "Audio/Source";
                "audio.rate" = 48000;
              };
            };
          }
        ];
      };
    };

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.lukas = {
      isNormalUser = true;
      description = "lukas";
      extraGroups = ["networkmanager" "wheel" "docker"];
    };

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
      firefox
      home-manager
      pavucontrol
      htop
      go
    ];

    virtualisation.docker.rootless = {
      enable = true;
      setSocketVariable = true;
    };

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "25.05"; # Did you read the comment?
  };
}

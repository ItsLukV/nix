{ self, inputs, ... }: {
  flake.nixosModules.niri = { pkgs, lib, ... }: {
    programs.niri = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri;
    };
  };

  perSystem = { pkgs, lib, self', ... }: {
    packages.myNiri = inputs.wrapper-modules.wrappers.niri.wrap {
      inherit pkgs;
      settings = {
        # Run your startup script
#        spawn-at-startup = [
#          { command = [ (lib.getExe ) ]; }
#        ];

        xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

        layout.gaps = 0;

        input = {
          keyboard.xkb.layout = "dk";
        };

        outputs = {
          # Samsung 1 - 2560x1440
          "DP-3" = {
            position = {
              _attrs = {
                x = 0;
                y = 0;
              };
            };
          };
          # Samsung 2 - 2560x1440
          "HDMI-A-1" = {
            position = {
              _attrs = {
                x = 2560;
                y = 0;
              };
            };
          };
          # Dell - 1280x1024
          "DP-2" = {
            position = {
              _attrs = {
                x = 5120;
                y = 208;
              };
            };
          };
        };

        binds = {
          # Core Application Binds
          "Mod+Q".spawn-sh = lib.getExe pkgs.firefox;
          "Mod+Shift+C".close-window = null;
          "Mod+Return".spawn-sh = lib.getExe pkgs.alacritty;
          # "Mod+S".spawn-sh = lib.getExe pkgs.walker;
          "Mod+M".spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";

          "Mod+Space".toggle-window-floating = null;

          # Workspace Switching
          "Mod+1".focus-workspace = 1;
          "Mod+2".focus-workspace = 2;
          "Mod+3".focus-workspace = 3;
          "Mod+4".focus-workspace = 4;
          "Mod+5".focus-workspace = 5;
          "Mod+6".focus-workspace = 6;
          "Mod+7".focus-workspace = 7;
          "Mod+8".focus-workspace = 8;
          "Mod+9".focus-workspace = 9;

          # Move Window to Workspace
          "Mod+Shift+1".move-column-to-workspace = 1;
          "Mod+Shift+2".move-column-to-workspace = 2;
          "Mod+Shift+3".move-column-to-workspace = 3;
          "Mod+Shift+4".move-column-to-workspace = 4;
          "Mod+Shift+5".move-column-to-workspace = 5;
          "Mod+Shift+6".move-column-to-workspace = 6;
          "Mod+Shift+7".move-column-to-workspace = 7;
          "Mod+Shift+8".move-column-to-workspace = 8;
          "Mod+Shift+9".move-column-to-workspace = 9;
        };
      };
    };
  };
}

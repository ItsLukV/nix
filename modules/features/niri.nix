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

        # Equivalent to gaps_in = 0 and gaps_out = 0
        layout.gaps = 0;

        # Input settings translated
        input = {
          keyboard.xkb.layout = "dk";
          # Mouse sensitivity maps here (0.5 to 1.0 depending on preference)
          mouse.accel-speed = 1.0;
        };
	/*
	outputs = {
          # Left Monitor
          "DP-3" = {
            mode = "2560x1440@164.983";
            position = { x = 0; y = 0; };
          };

          # Center Monitor
          "HDMI-A-1" = {
            mode = "2560x1440@144.000";
            position = { x = 2560; y = 0; };
          };

          # Right Monitor
          "DP-2" = {
            mode = "1280x1024@60.020";
            position = { x = 5120; y = 0; };
          };
        };
	*/
        binds = {
          # Core Application Binds
          "Mod+Q".spawn-sh = lib.getExe pkgs.firefox;
          "Mod+Shift+C".close-window = null;
          "Mod+Return".spawn-sh = lib.getExe pkgs.alacritty;
          "Mod+S".spawn-sh = lib.getExe pkgs.walker;
          "Mod+M".spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";

          # Floating (Available in Niri 25.11+)
          "Mod+Space".toggle-window-floating = null;

          # Grouping Binds (Translated to Niri's Column logic)
          "Mod+G".consume-window-into-column = null;
          "Mod+Shift+G".expel-window-from-column = null;
          "Mod+Tab".focus-window-down = null;
          "Mod+Apostrophe".focus-window-up = null;

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

          # Built-in Niri binds you'll likely want for movement
          "Mod+Left".focus-column-left = null;
          "Mod+Right".focus-column-right = null;
          "Mod+Shift+Left".move-column-left = null;
          "Mod+Shift+Right".move-column-right = null;
        };
      };
    };
  };
}

{self, ...}: {
  flake.homeModules.hyprland = {
    config,
    pkgs,
    inputs,
    lib,
    ...
  }: let
    wallpaper = ../../assets/wallpaper.png;
    terminal = pkgs.alacritty + "/bin/alacritty";
    mod = "SUPER";
    startupScript = pkgs.writeShellScriptBin "start" ''
      ${pkgs.waybar}/bin/waybar &
      swww-daemon &
      swww img ${wallpaper}
    '';
  in {
    home = {
      packages = [ pkgs.swww ];
      pointerCursor = {
        name = "Adwaita";
        package = pkgs.adwaita-icon-theme;
        size = 24;
        gtk.enable = true;
        x11.enable = true;
      };
    };
    wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    
    # Correct plugin reference
    plugins = [
      (inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland + "/lib/libhyprgroup.so")
      inputs.split-monitor-workspaces.packages.${pkgs.stdenv.hostPlatform.system}.split-monitor-workspaces
    ];

    settings = {
      general = {
        border_size = 2;
        gaps_in = 0;
        gaps_out = 0;
      };

      animations = {
        enabled = true;
        animation = [
          "workspaces, 0, 1, default"
        ];
      };

      env = [
        "XCURSOR_THEME,Adwaita"
        "XCURSOR_SIZE,24"
      ];

      exec-once = ["${startupScript}/bin/start"];
      
      group = {
        # Insert new windows after the currently active window
        insert_after_current = true;
        # Focus the group when a new window is added to it
        focus_removed_window = true;
      };

      # Use consistent variable name for modifier key
      "$mainMod" = mod; 

      bind = [
        "$mainMod, Q, exec, ${pkgs.firefox}/bin/firefox"
        "$mainMod SHIFT, C, killactive"
        "$mainMod, Return, exec, ${terminal}"
        "$mainMod, Space, togglefloating,"
        #"$mainMod, S, exec, ${pkgs.wofi}/bin/wofi --show drun"
        "$mainMod, S, exec, ${pkgs.walker}/bin/walker"
        "$mainMod, M, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"

        # Grouping keybinds - these are correct
        "$mainMod, G, togglegroup"
        "$mainMod SHIFT, G, lockactivegroup"
        "$mainMod, Tab, changegroupactive"
        "$mainMod, apostrophe, moveoutofgroup"

        # Split workspace binds
        "$mainMod, 1, split-workspace, 1"
        "$mainMod, 2, split-workspace, 2"
        "$mainMod, 3, split-workspace, 3"
        "$mainMod, 4, split-workspace, 4"
        "$mainMod, 5, split-workspace, 5"
        "$mainMod, 6, split-workspace, 6"
        "$mainMod, 7, split-workspace, 7"
        "$mainMod, 8, split-workspace, 8"
        "$mainMod, 9, split-workspace, 9"

        "$mainMod SHIFT, 1, split-movetoworkspace, 1"
        "$mainMod SHIFT, 2, split-movetoworkspace, 2"
        "$mainMod SHIFT, 3, split-movetoworkspace, 3"
        "$mainMod SHIFT, 4, split-movetoworkspace, 4"
        "$mainMod SHIFT, 5, split-movetoworkspace, 5"
        "$mainMod SHIFT, 6, split-movetoworkspace, 6"
        "$mainMod SHIFT, 7, split-movetoworkspace, 7"
        "$mainMod SHIFT, 8, split-movetoworkspace, 8"
        "$mainMod SHIFT, 9, split-movetoworkspace, 9"
      ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
        "$mainMod ALT, mouse:272, resizewindow"
      ];

      input = {
        kb_layout = "dk";
        follow_mouse = 1;
        sensitivity = 1;
        touchpad = {
          disable_while_typing = true;
          natural_scroll = true;
        };
      };

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        force_default_wallpaper = 0;
        animate_manual_resizes = false;
        animate_mouse_windowdragging = false;
      };
      device = [
        {
          name = "synps/2-synaptics-touchpad";
          sensitivity = 0.5; 
        }
        {
          name = "tpps/2-elan-trackpoint";
          sensitivity = 0.2;
        }
        {
          name="logitech-usb-receiver";
          sensitivity=-0.3;
        }
        {
          name="logitech-usb-receiver-keyboard-1";
          sensitivity=-0.3;
        }
      ];
    };
    
    extraConfig = ''
      plugin:split-monitor-workspaces:enable_persistent_workspaces = 0
    '';
    };
  };
}

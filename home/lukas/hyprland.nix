{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: let
  terminal = pkgs.alacritty + "/bin/alacritty";
  mod = "SUPER";
  startupScript = pkgs.writeShellScriptBin "start" ''
    ${pkgs.awww}/bin/awww-daemon &
    # Wait for aww daemon to be ready
    sleep 1 
  '';
  newWallpaper = import ./wallPaper.nix { inherit pkgs; };
in {
  home = {
    packages = [
      pkgs.awww
      pkgs.jq
      pkgs.curl
      pkgs.hyprlock
    ];
    pointerCursor = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
      size = 24;
      gtk.enable = true;
      x11.enable = true;
    };
    file.".config/hypr/xdph.conf".text = ''
    screencopy {
      custom_picker_binary = hyprland-preview-share-picker
    }
  '';
  };
  
  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    configType = "lua";

    extraConfig = ''
      -- environment
      hl.env("XCURSOR_THEME", "Adwaita")
      hl.env("XCURSOR_SIZE", "24")

      -- startup
      hl.on("hyprland.start", function()
        hl.exec_cmd("${startupScript}/bin/start")
        hl.exec_cmd("${newWallpaper}/bin/start")
      end)

      -- split-monitor-workspaces (now a native Lua package, the old C++
      -- plugin build is deprecated upstream)
      package.path = package.path .. ";${inputs.split-monitor-workspaces}/lua/?.lua"
      local smw = require("split-monitor-workspaces")
      smw.setup({
        workspace_count = 9,
        enable_persistent_workspaces = false,
      })

      -- look and feel
      hl.config({
        general = {
          border_size = 2,
          gaps_in = 0,
          gaps_out = 0,
        },

        group = {
          insert_after_current = true,
          focus_removed_window = true,
          col = {
            border_active = "rgba(ffffffff)",
            border_inactive = "rgba(00000000)",
          },

          groupbar = {
            enabled = true,
            render_titles = true,
            gradients = true,
            font_size = 16,
            font_weight_active = "ultraheavy",
            height = 24,

            -- Matching Waybar #ffffff (White)
            text_color = "0xffffffff",

            -- Matching Waybar #aaaaaa (Light Grey)
            text_color_inactive = "0xffaaaaaa",

            col = {
              -- Matching Waybar background-color: rgba(30, 30, 30, 1)
              active = "0xff1e1e1e",

              -- Using the same grey as inactive text for consistency
              inactive = "0xff333333",

              -- Optional: Spotify Green accent for locked/special states
              locked_active = "0xff1db954",
            },
          },
        },

        misc = {
          disable_hyprland_logo = true,
          disable_splash_rendering = true,
          force_default_wallpaper = 0,
          animate_manual_resizes = false,
          animate_mouse_windowdragging = false,
        },

        input = {
          kb_layout = "dk",
          follow_mouse = 1,
          sensitivity = 1,
          numlock_by_default = true,
          touchpad = {
            disable_while_typing = true,
            natural_scroll = true,
          },
        },

        animations = {
          enabled = true,
        },
      })

      hl.animation({ leaf = "workspaces", enabled = false, speed = 1, bezier = "default" })
      hl.animation({ leaf = "fadeSwitch", enabled = false, speed = 1, bezier = "default" })

      -- devices
      hl.device({ name = "synps/2-synaptics-touchpad", sensitivity = 0.5 })
      hl.device({ name = "tpps/2-elan-trackpoint", sensitivity = 0.2 })
      hl.device({ name = "logitech-usb-receiver", sensitivity = -0.3 })
      hl.device({ name = "logitech-usb-receiver-keyboard-1", sensitivity = -0.3 })

      -- keybinds
      local mainMod = "${mod}"

      hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd("${pkgs.firefox}/bin/firefox"))
      hl.bind(mainMod .. " + SHIFT + C", hl.dsp.window.close())
      hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd("${terminal}"))
      hl.bind(mainMod .. " + Space", hl.dsp.window.float({ action = "toggle" }))
      hl.bind(mainMod .. " + S", hl.dsp.exec_cmd("${pkgs.walker}/bin/walker"))
      hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))
      hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("${pkgs.hyprlock}/bin/hyprlock"))

      -- grouping keybinds
      hl.bind(mainMod .. " + G", hl.dsp.group.toggle())
      hl.bind(mainMod .. " + SHIFT + G", hl.dsp.group.lock_active())
      hl.bind(mainMod .. " + Tab", hl.dsp.group.next())
      hl.bind(mainMod .. " + apostrophe", hl.dsp.window.move({ out_of_group = true }))

      -- split workspace binds (split-monitor-workspaces Lua package)
      for i = 1, 9 do
        hl.bind(mainMod .. " + " .. i, smw.workspace(tostring(i)))
        hl.bind(mainMod .. " + SHIFT + " .. i, smw.move_to_workspace(tostring(i)))
      end

      -- mouse binds
      hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
      hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
      hl.bind(mainMod .. " + ALT + mouse:272", hl.dsp.window.resize(), { mouse = true })
    '';
  };
}

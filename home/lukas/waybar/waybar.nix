{
  pkgs,
  lib,
  ...
}: let
  spotify-color = pkgs.writeScript "waybar-spotify-color" (builtins.readFile ./spotify-color.py);
in {
  home.packages = with pkgs; [
    playerctl
    imagemagick
  ];
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    style = builtins.readFile ./style.css;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 0;
        modules-left = [
          "hyprland/workspaces"
        ];
        modules-center = [
          "clock"
        ];
        modules-right = [
          "network"
          "custom/spotify"
          "cpu"
          "memory"
          "pulseaudio"
        ];
        "hyprland/workspaces" = {
          format = "{icon}";
          show-empty-workspaces = false;
          format-active = "{icon}";
          # split-monitor-workspaces assigns each monitor a contiguous block of
          # `workspace_count` (9, see hyprland.nix) workspace IDs, so the
          # per-monitor workspace number is ((id - 1) mod 9) + 1, not the
          # base-10 wrap this used to assume.
          format-icons = builtins.listToAttrs (builtins.genList (i: let
            n = i + 1;
          in {
            name = toString n;
            value = toString (lib.mod (n - 1) 9 + 1);
          }) 36);
        };
        "custom/divider" = {
          format = " | ";
          interval = "once";
          tooltip = false;
        };
        clock = {
          format = "{:%H:%M:%S | %d/%m/%y}";
          tooltip-format = ''
            <big>{:%Y %B}</big>
            <tt><small>{calendar}</small></tt>'';
          interval = 1;
        };
        cpu = {
          interval = 1;
          format = "CPU: {usage}%";
          max-length = 15;
        };
        memory = {
          interval = 1;
          format = "Mem: {}% ";
          format-alt = "Mem: {used:0.1f}G ";
          max-length = 15;
        };
        network = {
          format = "{bandwidthUpBits:04} ↑↓ {bandwidthDownBits:04}";
          interval = 1;
          tooltip = false;
        };
        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "Battery {capacity}%";
          format-charging = "Charging: {capacity}%";
          format-plugged = "Plugged: {capacity}%";
        };
        pulseaudio = {
          format = "{icon} {volume}%";
          format-muted = "🔇 {volume}%";
          format-icons = {
            default = ["🔈" "🔉" "🔊"];
          };
          on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          on-click-right = "pavucontrol";
          scroll-step = 5;
          tooltip = true;
          tooltip-format = "{desc} {volume}% ({format_source})";
        };
        "custom/spotify" = {
          exec = "${spotify-color}";
          interval = 3;
          return-type = "json";
          escape = false;
          on-click = "playerctl -p spotify play-pause";
          on-scroll-up = "playerctl -p spotify volume 0.05+";
          on-scroll-down = "playerctl -p spotify volume 0.05-";
        };
      };
    };
  };
}

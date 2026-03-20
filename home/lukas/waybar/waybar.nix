{pkgs, ...}: {
  home.packages = with pkgs; [
    playerctl
  ];
  programs.waybar = {
    enable = true;
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
          "mpris"
          "cpu"
          "memory"
          "pulseaudio"
        ];
        "hyprland/workspaces" = {
          format = "{icon}";
          show-empty-workspaces = false;
          format-active = "{icon}";
          format-icons = {
            "1" = "1";
            "2" = "2";
            "3" = "3";
            "4" = "4";
            "5" = "5";
            "6" = "6";
            "7" = "7";
            "8" = "8";
            "9" = "9";
            "10" = "0";
            "11" = "1";
            "12" = "2";
            "13" = "3";
            "14" = "4";
            "15" = "5";
            "16" = "6";
            "17" = "7";
            "18" = "8";
            "19" = "9";
            "20" = "0";
            "21" = "1";
            "22" = "2";
            "23" = "3";
            "24" = "4";
            "25" = "5";
            "26" = "6";
            "27" = "7";
            "28" = "8";
            "29" = "9";
            "30" = "0";
          };
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
        mpris = {
          player = "spotify";
          format = "{player_icon} {title}";
          format-paused = "{status_icon} <i>{title}</i>";
          player-icons = {
            default = "▶";
            spotify = " ";
          };
          status-icons = {
            paused = "⏸";
          };
          "on-click" = "${pkgs.playerctl}/bin/playerctl play-pause -p spotify";
          # Scroll actions for volume
          "on-scroll-up" = "${pkgs.playerctl}/bin/playerctl -p spotify volume 0.05+";
          "on-scroll-down" = "${pkgs.playerctl}/bin/playerctl -p spotify volume 0.05-";
          max-length = 40;
        };
      };
    };
  };
}

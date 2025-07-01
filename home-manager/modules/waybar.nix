{
  programs.waybar = {
    enable = true;
    style = ''
      /* Main bar background */
      window#waybar {
        background-color: rgba(30, 30, 30, 0.9); /* Dark semi-transparent */
        color: #ffffff;
      }

      /* Workspace buttons */
      #workspaces button {
        background: rgba(255, 255, 255, 0.1);
        color: #aaaaaa;
        font-size: 20px;
        padding: 0 5px;
        border-radius: 4px;
        margin: 2px;
      }

      /* Active workspace */
      #workspaces button.active {
        background: rgba(255, 255, 255, 0.1);
        color: #ffffff;
      }

      /* Hover effect */
      #workspaces button:hover {
        background: rgba(255, 255, 255, 0.2);
      }
    '';
    settings = {
      mainBar = {
        # Note: Some setups use "mainBar" instead of "mainbar"
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
          "cpu"
          "custom/divider"
          "memory"
        ];
        "hyprland/workspaces" = {
          format = "{icon}";
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
            "10" = "1";
            "11" = "2";
            "12" = "3";
            "13" = "4";
            "14" = "5";
            "15" = "6";
            "16" = "7";
            "17" = "8";
            "18" = "9";
            "19" = "1";
            "20" = "2";
            "21" = "3";
            "22" = "4";
            "23" = "5";
            "24" = "6";
            "25" = "7";
            "26" = "8";
            "27" = "9";
          };
        };
        "custom/divider" = {
          format = " | ";
          interval = "once";
          tooltip = false;
        };
        clock = {
          format = "{:%H:%M:%S | %d/%m}";
          tooltip-format = ''
            <big>{:%Y %B}</big>
            <tt><small>{calendar}</small></tt>'';
       		interval = 1; 
				};
      };
    };
  };
}

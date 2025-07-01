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
        background: rgb(155, 155, 155); /* Your gray color */
        color: #000000; /* Dark text for contrast */
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
      };
    };
  };
}

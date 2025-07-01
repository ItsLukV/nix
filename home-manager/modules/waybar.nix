{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {  # Note: Some setups use "mainBar" instead of "mainbar"
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

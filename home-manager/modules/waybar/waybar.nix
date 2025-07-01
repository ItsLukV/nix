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
	"custom/divider" = {
          format = " | ";
          interval = "once";
          tooltip = false;
        };
      };
    };
  };
}

{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {  # Note: Some setups use "mainBar" instead of "mainbar"
        layer = "top";
        position = "top";
        height = 30;
        modules-left = [
          "hyprland/workspaces"  # More commonly used than "tags"
        ];
      };
    };
  };
}

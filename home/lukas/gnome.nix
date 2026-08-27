{ pkgs, ... }:
{
  home.packages = with pkgs.gnomeExtensions; [
    dash-to-panel
  ] ++ [
    pkgs.gnome-screenshot
  ];

  dconf.settings = {
    "org/gnome/shell" = {
      enabled-extensions = [
        "dash-to-panel@jderose9.github.com"
      ];
    };

    # GNOME hides minimize/maximize by default (expects Activities overview
    # instead), which left most windows with only a close button. Restore
    # both since dash-to-panel gives us a real taskbar to minimize to.
    "org/gnome/desktop/wm/preferences" = {
      button-layout = "appmenu:minimize,maximize,close";
    };

    "org/gnome/shell/extensions/dash-to-panel" = {
      multi-monitors = true;
    };

    # Built-in GNOME screenshot UI: region/window/full capture with clipboard copy
    "org/gnome/shell/keybindings" = {
      show-screenshot-ui = [ "<Shift><Super>s" ];
    };
  };
}

{ lib, pkgs, ... }:
let
  # Only show Spotify in the panel/card; every other MPRIS player is ignored.
  media-controller = pkgs.gnomeExtensions.media-controller.overrideAttrs (old: {
    postPatch = (old.postPatch or "") + ''
      substituteInPlace mpris.js \
        --replace-fail \
          "return name.startsWith(MPRIS_PREFIX) && !IGNORED_BUS_NAMES.includes(name);" \
          "return name.startsWith(MPRIS_PREFIX) && !IGNORED_BUS_NAMES.includes(name) && name.toLowerCase().includes('spotify');"
    '';
  });
in
{
  home.packages = with pkgs.gnomeExtensions; [
    dash-to-panel
    appindicator
  ] ++ [
    media-controller
    pkgs.gnome-screenshot
    pkgs.playerctl
  ];

  dconf.settings = {
    "org/gnome/desktop/input-sources" = {
      sources = [ (lib.hm.gvariant.mkTuple [ "xkb" "dk" ]) ];
      xkb-options = [ ];
    };

    "org/gnome/desktop/peripherals/touchpad" = {
      speed = 1.0;
      two-finger-scrolling-enabled = true;
    };

    "org/gnome/shell" = {
      enabled-extensions = [
        "dash-to-panel@jderose9.github.com"
        "appindicatorsupport@rgcjonas.gmail.com"
        "media-controller@naimur"
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

    # Default Alt+Tab groups windows by application (one icon per app); make
    # it switch between individual windows instead, so e.g. every Firefox
    # window shows up as its own entry.
    "org/gnome/desktop/wm/keybindings" = {
      switch-applications = [ ];
      switch-applications-backward = [ ];
      switch-windows = [ "<Alt>Tab" ];
      switch-windows-backward = [ "<Shift><Alt>Tab" ];

      # Free up Ctrl+Alt+Up/Down (and the Shift variant) which GNOME uses
      # for workspace switching by default — same combo VS Code wants for
      # editor.action.insertCursorAbove/Below.
      switch-to-workspace-up = [ ];
      switch-to-workspace-down = [ ];
      move-to-workspace-up = [ ];
      move-to-workspace-down = [ ];
    };
  };
}

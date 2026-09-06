{ pkgs, ... }:
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
  };
}

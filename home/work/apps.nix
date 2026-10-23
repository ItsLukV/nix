{ pkgs, config, ... }:
{
  home.packages = with pkgs; [
    teams-for-linux
    onedrive
  ];

  # Outlook has no native Linux build, so run it as an app-mode Chromium
  # window (separate profile dir keeps its cookies/login out of normal
  # browsing) and expose it as its own launcher entry.
  xdg.desktopEntries.outlook = {
    name = "Outlook";
    genericName = "Email client";
    comment = "Outlook web app in its own window";
    icon = "mail-client";
    categories = [ "Network" "Email" ];
    exec = ''${pkgs.ungoogled-chromium}/bin/chromium --app=https://outlook.office.com/mail/ --class=Outlook --user-data-dir=${config.home.homeDirectory}/.local/share/outlook-pwa'';
    terminal = false;
  };
}

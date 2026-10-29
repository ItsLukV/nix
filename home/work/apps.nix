{ pkgs, config, ... }: let
  # Copy just the one icon so the 250M Papirus theme stays out of the closure.
  outlookIcon = pkgs.runCommand "outlook-icon.svg" { } ''
    cp ${pkgs.papirus-icon-theme}/share/icons/Papirus/64x64/apps/ms-outlook.svg $out
  '';
in {
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
    icon = "${outlookIcon}";
    categories = [ "Network" "Email" ];
    exec = ''${pkgs.ungoogled-chromium}/bin/chromium --app=https://outlook.office.com/mail/ --user-data-dir=${config.home.homeDirectory}/.local/share/outlook-pwa'';
    terminal = false;
    settings.StartupWMClass = "chrome-outlook.office.com__mail_-Default";
  };
}

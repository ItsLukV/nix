{pkgs, ...}: {
    environment.systemPackages = with pkgs; [
    libreoffice-qt
    hunspell
    hunspellDicts.da_DK
  ];
}

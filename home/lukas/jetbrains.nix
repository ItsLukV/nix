{pkgs, home, ...}: {
  home = {
    packages = with pkgs; [
      jetbrains.idea
      jetbrains.goland
      gradle
    ];
    sessionVariables = {
      _JAVA_AWT_WM_NONREPARENTING = "1";
      IDEA_JDK_VV = "1";
    };
  };
  programs.java = {
    enable = true;
    package = pkgs.jdk21;
  };

  home.file.".jdk25".source = pkgs.jdk25.home;

  # Makes every repo's gradlew resolve toolchains against these nix-provided
  # JDKs instead of downloading its own (prebuilt) JDK from Adoptium, which
  # needs nix-ld and is why projects were pinning a flake.nix just for this.
  home.file.".gradle/gradle.properties".text = ''
    org.gradle.java.installations.auto-detect=true
    org.gradle.java.installations.auto-download=false
    org.gradle.java.installations.paths=${pkgs.jdk8.home},${pkgs.jdk11.home},${pkgs.jdk17.home},${pkgs.jdk21.home},${pkgs.jdk25.home}
  '';
}

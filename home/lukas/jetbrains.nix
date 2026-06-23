{pkgs, home, ...}: {
  home = {
    packages = with pkgs; [
      jetbrains.idea
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
}

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
  programs.bash.initExtra = ''
    idea() {
      # If no path is provided, use "."
      local path="''${1:-.}"
      command idea "$path" > /dev/null 2>&1 & disown
    }
  '';
  programs.java = {
    enable = true;
    package = pkgs.jdk21; 
  };

  home.file.".jdk25".source = pkgs.jdk25.home;
}

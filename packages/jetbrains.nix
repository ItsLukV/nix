{pkgs, ...} : {
  environment.systemPackages = with pkgs; [
    jetbrains.idea
  ];

programs.java = {
  enable = true;
  package = pkgs.jdk25;
};
}

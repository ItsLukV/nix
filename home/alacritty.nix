{pkgs, ...}: {
        programs.alacritty = {
  enable = true;
  settings = {
    font = {
      normal = {
        family = "DejaVu Sans Mono";
        style = "Book";
      };
      size = 20;
    };
  };
};
}

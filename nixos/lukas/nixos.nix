{ pkgs, inputs, ... }:

{
  imports = [
    ./nvf.nix
  ];


  programs.bash.enable = true;

  users.users.lukas = {
    isNormalUser = true;
    home = "/home/lukas";
    extraGroups = [ "docker" ];
    shell = pkgs.bash;
  };
}

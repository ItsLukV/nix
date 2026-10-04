{ pkgs, ... }:

{
  users.users.work = {
    isNormalUser = true;
    home = "/home/work";
    description = "work";
    extraGroups = [ "networkmanager" "docker" ];
    shell = pkgs.bash;
  };
}

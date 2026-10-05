{ pkgs, ... }:

{
  users.users.work = {
    isNormalUser = true;
    home = "/home/work";
    description = "work";
    extraGroups = [ "networkmanager" "docker" "wheel" ];
    shell = pkgs.bash;
  };
}

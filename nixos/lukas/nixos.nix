{ pkgs, inputs, ... }:

{
  imports = [
    ./nvf.nix
  ];

  users.users.lukas = {
    isNormalUser = true;
    home = "/home/lukas";
    extraGroups = [ "docker" ];
    shell = pkgs.bash;
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
}

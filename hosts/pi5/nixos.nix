{ config, pkgs, lib, nixos-raspberrypi, ... }:
{
  imports = with nixos-raspberrypi.nixosModules; [
    raspberry-pi-5.base   # vendor kernel + firmware (prebuilt in nvmd's cache)
    sd-image              # provides config.system.build.sdImage + boots as "kernel"
    # raspberry-pi-5.display-vc4  # uncomment only if you attach a monitor
  ];

  hardware.raspberry-pi.config.all.base-dt-params = {
    fan_temp0        = { enable = true; value = "60000"; };  # fan starts (60°C)
    fan_temp0_hyst   = { enable = true; value = "5000";  };
    fan_temp1        = { enable = true; value = "67000"; };  # low speed
    fan_temp1_hyst   = { enable = true; value = "5000";  };
    fan_temp2        = { enable = true; value = "72000"; };  # medium
    fan_temp2_hyst   = { enable = true; value = "5000";  };
    fan_temp3        = { enable = true; value = "77000"; };  # full speed
    fan_temp3_hyst   = { enable = true; value = "5000";  };
  };

  networking.hostName = "pi5";
  networking.networkmanager.enable = true;
  time.timeZone = "Europe/Copenhagen";

  sdImage.compressImage = false;  # emit a raw .img for dd

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    extra-substituters = [ "https://nixos-raspberrypi.cachix.org" ];
    extra-trusted-public-keys = [
      "nixos-raspberrypi.cachix.org-1:4iMO9LXa8BqhU+Rpg6LQKiGa2lsNh/j2oiYLNOQ5sPI="
    ];
  };

  users.users.lukas.initialPassword = "changeme";
  users.users.root.initialPassword = "changeme";

  virtualisation.docker.enable = true;
  virtualisatio.docker.package = pkgs.docker_29;
  users.users.lukas = {
    isNormalUser = true;
    home = "/home/lukas";
    shell = pkgs.bash;
    extraGroups = [ "wheel" "networkmanager" "docker" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICPYr6zh7M97VLYcJj+/jgulYxayZXuYEyc3TFxVY9zs"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB0Hrb98xbqwgk0y8/dn0YcWC7cKz7hE2xneZug0657n"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFGC6NTKgq2AG2isWldkwmVKw0F/GIGm+PJhQ3yee8NR"
    ];
  };
  nix.settings.trusted-users = [ "root" "lukas" ];
  security.sudo.wheelNeedsPassword = false;
  programs.bash.enable = true;

  services.tailscale.enable = true;
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
  };

  nixpkgs.config.allowUnfree = true;   # minecraft-server is unfree

  system.stateVersion = "25.05";

  environment.systemPackages = with pkgs; [ git vim htop tmux ripgrep wget ];
  environment.shellAliases.rebuild = "sudo nixos-rebuild switch --flake ~/nix#$(hostname)";
}

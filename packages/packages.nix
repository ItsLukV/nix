{pkgs,...}: {
  imports = [
    ./jetbrains.nix
    ./bash.nix
  ];

  environment.systemPackages = with pkgs; [
    prismlauncher
    fastfetch
  ];
}

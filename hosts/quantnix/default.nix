{ inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix

    ./boot.nix
    ./nvidia.nix
    ./networking.nix
    ./audio.nix
    ./users.nix
    ./hyprland.nix
    ./packages.nix
    ./docker.nix
  ];

  nixpkgs.overlays = [
    inputs.nix-vscode-extensions.overlays.default
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  time.timeZone = "Europe/Moscow";
  security.sudo.enable = true;
  security.sudo.wheelNeedsPassword = true;

  system.stateVersion = "26.05";
}

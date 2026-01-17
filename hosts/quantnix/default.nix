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
  ];

  nixpkgs.overlays = [
    inputs.nix-vscode-extensions.overlays.default
  ];

  time.timeZone = "Europe/Moscow";

  security.sudo.enable = true;
  security.sudo.wheelNeedsPassword = false;

  system.stateVersion = "26.05";
}

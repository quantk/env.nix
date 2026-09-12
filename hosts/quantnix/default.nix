{ inputs, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix

    ./boot.nix
    ./nvidia.nix
    ./networking.nix
    ./print.nix
    ./audio.nix
    ./users.nix
    ./hyprland.nix
    ./packages.nix
    ./docker.nix
    ./k3s.nix
  ];

  nixpkgs.overlays = [
    inputs.nix-vscode-extensions.overlays.default
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  #  environment.variables = {
  #    NPM_CONFIG_REGISTRY = "https://registry.npmmirror.com";
  #  };

  time.timeZone = "Europe/Moscow";
  security.sudo.enable = true;
  security.sudo.wheelNeedsPassword = true;
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      stdenv.cc.cc.lib
      zlib
      openssl
    ];
  };

  system.stateVersion = "26.05";
}

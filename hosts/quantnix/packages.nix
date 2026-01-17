{ pkgs, ... }:

{
  # =========================
  # Packages
  # =========================

  environment.systemPackages = with pkgs; [
    git
    less
    wget
    htop
    btop
    kitty
    firefox
    gnome-calendar
    pavucontrol
    networkmanagerapplet
  ];

  environment.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";
  };
}

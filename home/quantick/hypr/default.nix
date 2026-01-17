{ config, pkgs, ... }:

{
  # =========================
  # Hypr
  # =========================

  xdg.configFile."hypr/hyprland.conf".source = ./hyprland.conf;
  xdg.configFile."hypr/hyprpaper.conf".source = ./hyprpaper.conf;
  xdg.configFile."hypr/hyprlock.conf".source = ./hyprlock.conf;
}

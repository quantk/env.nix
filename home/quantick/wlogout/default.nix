{ pkgs, ... }:

{
  # =========================
  # Wlogout
  # =========================

  xdg.configFile."wlogout/layout".source = ./layout;
}

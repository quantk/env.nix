{ config, pkgs, ... }:

{
  # =========================
  # Kitty terminal
  # =========================

  xdg.configFile."kitty/kitty.conf".source = ./kitty.conf;
}
